import json
from app.main import app
from fastapi.openapi.utils import get_openapi

def convert_to_swagger2(openapi_schema):
    """
    Very basic conversion from OpenAPI 3.x to Swagger 2.0 
    tailored for this microservice's needs.
    """
    swagger2 = {
        "swagger": "2.0",
        "info": openapi_schema["info"],
        "paths": {},
        "definitions": {}
    }
    
    for path, methods in openapi_schema.get("paths", {}).items():
        swagger2["paths"][path] = {}
        for method, details in methods.items():
            swagger_method = {
                "summary": details.get("summary"),
                "description": details.get("description", ""),
                "operationId": details.get("operationId"),
                "responses": {},
                "parameters": []
            }
            
            # Handle request body (multipart/form-data for uploads)
            if "requestBody" in details:
                content = details["requestBody"].get("content", {})
                if "multipart/form-data" in content:
                    swagger_method["consumes"] = ["multipart/form-data"]
                    schema_ref = content["multipart/form-data"].get("schema", {}).get("$ref")
                    if schema_ref:
                        schema_name = schema_ref.split("/")[-1]
                        schema = openapi_schema.get("components", {}).get("schemas", {}).get(schema_name, {})
                        for prop_name, prop_details in schema.get("properties", {}).items():
                            param = {
                                "name": prop_name,
                                "in": "formData",
                                "required": prop_name in schema.get("required", []),
                                "type": "file" if prop_details.get("format") == "binary" else prop_details.get("type", "string")
                            }
                            swagger_method["parameters"].append(param)
            
            # Handle simple query parameters if any (none in this app yet)
            for param in details.get("parameters", []):
                swagger_method["parameters"].append(param)
            
            # Handle responses
            for status, resp_details in details.get("responses", {}).items():
                swagger_resp = {
                    "description": resp_details.get("description", "Successful Response")
                }
                content = resp_details.get("content", {})
                if "application/json" in content:
                    resp_schema = content["application/json"].get("schema")
                    if resp_schema:
                        if "$ref" in resp_schema:
                            ref = resp_schema["$ref"].replace("#/components/schemas/", "#/definitions/")
                            swagger_resp["schema"] = {"$ref": ref}
                        else:
                            # Basic schema transformation for inline objects
                            swagger_resp["schema"] = resp_schema
                            
                swagger_method["responses"][status] = swagger_resp
                
            swagger2["paths"][path][method] = swagger_method

    # Copy and transform definitions
    for schema_name, schema in openapi_schema.get("components", {}).get("schemas", {}).items():
        def fix_schema(s):
            if isinstance(s, dict):
                new_s = {}
                for k, v in s.items():
                    if k == "$ref":
                        new_s[k] = v.replace("#/components/schemas/", "#/definitions/")
                    elif k in ["anyOf", "oneOf"]:
                        # Swagger 2.0 doesn't support anyOf/oneOf well
                        # For simple usage, we just take the first one or treat as generic object
                        if v and isinstance(v, list) and len(v) > 0:
                            new_s.update(fix_schema(v[0]))
                        else:
                            new_s["type"] = "object"
                    else:
                        new_s[k] = fix_schema(v)
                return new_s
            elif isinstance(s, list):
                return [fix_schema(item) for item in s]
            return s
            
        swagger2["definitions"][schema_name] = fix_schema(schema)

    return swagger2

def generate_spec():
    # Force OpenAPI 3.0.0 during generation to reduce 3.1 specific noise
    schema = get_openapi(
        title=app.title,
        version=app.version,
        openapi_version="3.0.0",
        description=app.description or "",
        routes=app.routes,
    )
    
    swagger2 = convert_to_swagger2(schema)
    
    with open("openapi.json", "w") as f:
        json.dump(swagger2, f, indent=2)
    print("Swagger 2.0 spec generated as openapi.json")

if __name__ == "__main__":
    generate_spec()
