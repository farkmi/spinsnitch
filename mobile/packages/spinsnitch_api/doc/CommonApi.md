# spinsnitch_api.api.CommonApi

## Load the API package
```dart
import 'package:spinsnitch_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getHealthyRoute**](CommonApi.md#gethealthyroute) | **GET** /-/healthy | Get healthy (liveness probe)
[**getReadyRoute**](CommonApi.md#getreadyroute) | **GET** /-/ready | Get ready (readiness probe)
[**getSwaggerRoute**](CommonApi.md#getswaggerroute) | **GET** /swagger.yml | Get swagger.yml
[**getVersionRoute**](CommonApi.md#getversionroute) | **GET** /-/version | Get version


# **getHealthyRoute**
> getHealthyRoute()

Get healthy (liveness probe)

This endpoint returns 200 when the service is healthy. Returns an human readable string about the current service status. In addition to readiness probes, it performs actual write probes. Note that /-/healthy is private (shielded by the mgmt-secret) as it may expose sensitive information about your service.

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Management
//defaultApiClient.getAuthentication<ApiKeyAuth>('Management').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Management').apiKeyPrefix = 'Bearer';

final api_instance = CommonApi();

try {
    api_instance.getHealthyRoute();
} catch (e) {
    print('Exception when calling CommonApi->getHealthyRoute: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[Management](../README.md#Management)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getReadyRoute**
> getReadyRoute()

Get ready (readiness probe)

This endpoint returns 200 when the service is ready to serve traffic. Does read-only probes apart from the general server ready state. Note that /-/ready is typically public (and not shielded by a mgmt-secret), we thus prevent information leakage here and only return `\"Ready.\"`.

### Example
```dart
import 'package:spinsnitch_api/api.dart';

final api_instance = CommonApi();

try {
    api_instance.getReadyRoute();
} catch (e) {
    print('Exception when calling CommonApi->getReadyRoute: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getSwaggerRoute**
> getSwaggerRoute()

Get swagger.yml

OpenAPI Specification ver. 2 (fka Swagger) Returns our handcrafted and validated `swagger.yml`.

### Example
```dart
import 'package:spinsnitch_api/api.dart';

final api_instance = CommonApi();

try {
    api_instance.getSwaggerRoute();
} catch (e) {
    print('Exception when calling CommonApi->getSwaggerRoute: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getVersionRoute**
> getVersionRoute()

Get version

This endpoint returns the module name, commit and build-date baked into the app binary.

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Management
//defaultApiClient.getAuthentication<ApiKeyAuth>('Management').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Management').apiKeyPrefix = 'Bearer';

final api_instance = CommonApi();

try {
    api_instance.getVersionRoute();
} catch (e) {
    print('Exception when calling CommonApi->getVersionRoute: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

void (empty response body)

### Authorization

[Management](../README.md#Management)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

