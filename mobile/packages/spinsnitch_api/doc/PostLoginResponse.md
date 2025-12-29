# spinsnitch_api.model.PostLoginResponse

## Load the model package
```dart
import 'package:spinsnitch_api/api.dart';
```

## Properties
Name | Type | Description | Notes
------------ | ------------- | ------------- | -------------
**accessToken** | **String** | Access token required for accessing protected API endpoints | 
**expiresIn** | **int** | Access token expiry in seconds | 
**refreshToken** | **String** | Refresh token for refreshing the access token once it expires | 
**tokenType** | **String** | Type of access token, will always be `bearer` | 

[[Back to Model list]](../README.md#documentation-for-models) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to README]](../README.md)


