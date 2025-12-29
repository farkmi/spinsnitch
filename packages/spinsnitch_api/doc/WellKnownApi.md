# spinsnitch_api.api.WellKnownApi

## Load the API package
```dart
import 'package:spinsnitch_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**getAndroidDigitalAssetLinksRoute**](WellKnownApi.md#getandroiddigitalassetlinksroute) | **GET** /.well-known/assetlinks.json | Android Digital Asset Links
[**getAppleAppSiteAssociationRoute**](WellKnownApi.md#getappleappsiteassociationroute) | **GET** /.well-known/apple-app-site-association | Apple App Site Association


# **getAndroidDigitalAssetLinksRoute**
> getAndroidDigitalAssetLinksRoute()

Android Digital Asset Links

Returns the Android Digital Asset Links file.

### Example
```dart
import 'package:spinsnitch_api/api.dart';

final api_instance = WellKnownApi();

try {
    api_instance.getAndroidDigitalAssetLinksRoute();
} catch (e) {
    print('Exception when calling WellKnownApi->getAndroidDigitalAssetLinksRoute: $e\n');
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

# **getAppleAppSiteAssociationRoute**
> getAppleAppSiteAssociationRoute()

Apple App Site Association

Returns the Apple App Site Association file.

### Example
```dart
import 'package:spinsnitch_api/api.dart';

final api_instance = WellKnownApi();

try {
    api_instance.getAppleAppSiteAssociationRoute();
} catch (e) {
    print('Exception when calling WellKnownApi->getAppleAppSiteAssociationRoute: $e\n');
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

