# spinsnitch_api.api.PushApi

## Load the API package
```dart
import 'package:spinsnitch_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**putUpdatePushTokenRoute**](PushApi.md#putupdatepushtokenroute) | **PUT** /api/v1/push/token | Adds a push token to the user


# **putUpdatePushTokenRoute**
> putUpdatePushTokenRoute(payload)

Adds a push token to the user

Adds a push token for the given provider to the current user. If the oldToken is present it will be deleted. Currently only the provider 'fcm' is supported.

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = PushApi();
final payload = PutUpdatePushTokenPayload(); // PutUpdatePushTokenPayload | 

try {
    api_instance.putUpdatePushTokenRoute(payload);
} catch (e) {
    print('Exception when calling PushApi->putUpdatePushTokenRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payload** | [**PutUpdatePushTokenPayload**](PutUpdatePushTokenPayload.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

