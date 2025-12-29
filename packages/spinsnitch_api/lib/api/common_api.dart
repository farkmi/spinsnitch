//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CommonApi {
  CommonApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get healthy (liveness probe)
  ///
  /// This endpoint returns 200 when the service is healthy. Returns an human readable string about the current service status. In addition to readiness probes, it performs actual write probes. Note that /-/healthy is private (shielded by the mgmt-secret) as it may expose sensitive information about your service.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getHealthyRouteWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/-/healthy';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get healthy (liveness probe)
  ///
  /// This endpoint returns 200 when the service is healthy. Returns an human readable string about the current service status. In addition to readiness probes, it performs actual write probes. Note that /-/healthy is private (shielded by the mgmt-secret) as it may expose sensitive information about your service.
  Future<void> getHealthyRoute() async {
    final response = await getHealthyRouteWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get ready (readiness probe)
  ///
  /// This endpoint returns 200 when the service is ready to serve traffic. Does read-only probes apart from the general server ready state. Note that /-/ready is typically public (and not shielded by a mgmt-secret), we thus prevent information leakage here and only return `\"Ready.\"`.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getReadyRouteWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/-/ready';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get ready (readiness probe)
  ///
  /// This endpoint returns 200 when the service is ready to serve traffic. Does read-only probes apart from the general server ready state. Note that /-/ready is typically public (and not shielded by a mgmt-secret), we thus prevent information leakage here and only return `\"Ready.\"`.
  Future<void> getReadyRoute() async {
    final response = await getReadyRouteWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get swagger.yml
  ///
  /// OpenAPI Specification ver. 2 (fka Swagger) Returns our handcrafted and validated `swagger.yml`.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getSwaggerRouteWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/swagger.yml';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get swagger.yml
  ///
  /// OpenAPI Specification ver. 2 (fka Swagger) Returns our handcrafted and validated `swagger.yml`.
  Future<void> getSwaggerRoute() async {
    final response = await getSwaggerRouteWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get version
  ///
  /// This endpoint returns the module name, commit and build-date baked into the app binary.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getVersionRouteWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/-/version';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get version
  ///
  /// This endpoint returns the module name, commit and build-date baked into the app binary.
  Future<void> getVersionRoute() async {
    final response = await getVersionRouteWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
