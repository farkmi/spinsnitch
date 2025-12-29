# spinsnitch_api.api.VinylApi

## Load the API package
```dart
import 'package:spinsnitch_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getMistreatedRoute**](VinylApi.md#getmistreatedroute) | **GET** /api/v1/vinyls/mistreated | Get mistreated records
[**getRecentPlaysRoute**](VinylApi.md#getrecentplaysroute) | **GET** /api/v1/vinyls/recent-plays | Get recent track plays
[**getVinylSearchRoute**](VinylApi.md#getvinylsearchroute) | **GET** /api/v1/vinyls/search | Search for vinyl records on Discogs
[**getVinylsRoute**](VinylApi.md#getvinylsroute) | **GET** /api/v1/vinyls | List all vinyl records
[**postPlayRoute**](VinylApi.md#postplayroute) | **POST** /api/v1/vinyls/play | Register a play
[**postRecognizeRoute**](VinylApi.md#postrecognizeroute) | **POST** /api/v1/vinyls/recognize | Recognize a music snippet
[**postVinylRoute**](VinylApi.md#postvinylroute) | **POST** /api/v1/vinyls | Add a new vinyl record


# **getMistreatedRoute**
> List<MistreatedRecord> getMistreatedRoute()

Get mistreated records

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = VinylApi();

try {
    final result = api_instance.getMistreatedRoute();
    print(result);
} catch (e) {
    print('Exception when calling VinylApi->getMistreatedRoute: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<MistreatedRecord>**](MistreatedRecord.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getRecentPlaysRoute**
> RecentPlaysResponse getRecentPlaysRoute(limit)

Get recent track plays

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = VinylApi();
final limit = 56; // int | Max number of plays to return

try {
    final result = api_instance.getRecentPlaysRoute(limit);
    print(result);
} catch (e) {
    print('Exception when calling VinylApi->getRecentPlaysRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **limit** | **int**| Max number of plays to return | [optional] [default to 10]

### Return type

[**RecentPlaysResponse**](RecentPlaysResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getVinylSearchRoute**
> List<VinylSearchResult> getVinylSearchRoute(q)

Search for vinyl records on Discogs

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = VinylApi();
final q = q_example; // String | Search query (artist, title, barcode)

try {
    final result = api_instance.getVinylSearchRoute(q);
    print(result);
} catch (e) {
    print('Exception when calling VinylApi->getVinylSearchRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **q** | **String**| Search query (artist, title, barcode) | 

### Return type

[**List<VinylSearchResult>**](VinylSearchResult.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getVinylsRoute**
> List<VinylRecord> getVinylsRoute()

List all vinyl records

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = VinylApi();

try {
    final result = api_instance.getVinylsRoute();
    print(result);
} catch (e) {
    print('Exception when calling VinylApi->getVinylsRoute: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List<VinylRecord>**](VinylRecord.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postPlayRoute**
> postPlayRoute(payload)

Register a play

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = VinylApi();
final payload = PlayPayload(); // PlayPayload | 

try {
    api_instance.postPlayRoute(payload);
} catch (e) {
    print('Exception when calling VinylApi->postPlayRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payload** | [**PlayPayload**](PlayPayload.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postRecognizeRoute**
> RecognitionResult postRecognizeRoute(file)

Recognize a music snippet

Upload an audio snippet to identify the music.

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = VinylApi();
final file = BINARY_DATA_HERE; // MultipartFile | 

try {
    final result = api_instance.postRecognizeRoute(file);
    print(result);
} catch (e) {
    print('Exception when calling VinylApi->postRecognizeRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **file** | **MultipartFile**|  | 

### Return type

[**RecognitionResult**](RecognitionResult.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: multipart/form-data
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postVinylRoute**
> PostVinylRoute200Response postVinylRoute(payload)

Add a new vinyl record

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = VinylApi();
final payload = VinylPayload(); // VinylPayload | 

try {
    final result = api_instance.postVinylRoute(payload);
    print(result);
} catch (e) {
    print('Exception when calling VinylApi->postVinylRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payload** | [**VinylPayload**](VinylPayload.md)|  | [optional] 

### Return type

[**PostVinylRoute200Response**](PostVinylRoute200Response.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

