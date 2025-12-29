# spinsnitch_api.api.AuthApi

## Load the API package
```dart
import 'package:spinsnitch_api/api.dart';
```

All URIs are relative to *http://localhost*

Method | HTTP request | Description
------------- | ------------- | -------------
[**deleteUserAccountRoute**](AuthApi.md#deleteuseraccountroute) | **DELETE** /api/v1/auth/account | Delete user account
[**getCompleteRegisterRoute**](AuthApi.md#getcompleteregisterroute) | **GET** /api/v1/auth/register | Page to complete registration
[**getUserInfoRoute**](AuthApi.md#getuserinforoute) | **GET** /api/v1/auth/userinfo | Get user info
[**postChangePasswordRoute**](AuthApi.md#postchangepasswordroute) | **POST** /api/v1/auth/change-password | Change local user's password
[**postCompleteRegisterRoute**](AuthApi.md#postcompleteregisterroute) | **POST** /api/v1/auth/register/{registrationToken} | Complete registration
[**postForgotPasswordCompleteRoute**](AuthApi.md#postforgotpasswordcompleteroute) | **POST** /api/v1/auth/forgot-password/complete | Completes password reset for local user
[**postForgotPasswordRoute**](AuthApi.md#postforgotpasswordroute) | **POST** /api/v1/auth/forgot-password | Initiate password reset for local user
[**postLoginRoute**](AuthApi.md#postloginroute) | **POST** /api/v1/auth/login | Login with local user
[**postLogoutRoute**](AuthApi.md#postlogoutroute) | **POST** /api/v1/auth/logout | Log out local user
[**postRefreshRoute**](AuthApi.md#postrefreshroute) | **POST** /api/v1/auth/refresh | Refresh tokens
[**postRegisterRoute**](AuthApi.md#postregisterroute) | **POST** /api/v1/auth/register | Registers a local user


# **deleteUserAccountRoute**
> deleteUserAccountRoute(payload)

Delete user account

Completely delete the user account. This action is irreversible and therefore requires additional password authentication.

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = AuthApi();
final payload = DeleteUserAccountPayload(); // DeleteUserAccountPayload | 

try {
    api_instance.deleteUserAccountRoute(payload);
} catch (e) {
    print('Exception when calling AuthApi->deleteUserAccountRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payload** | [**DeleteUserAccountPayload**](DeleteUserAccountPayload.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getCompleteRegisterRoute**
> getCompleteRegisterRoute(token)

Page to complete registration

### Example
```dart
import 'package:spinsnitch_api/api.dart';

final api_instance = AuthApi();
final token = token_example; // String | Registration token to complete the registration process

try {
    api_instance.getCompleteRegisterRoute(token);
} catch (e) {
    print('Exception when calling AuthApi->getCompleteRegisterRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **token** | **String**| Registration token to complete the registration process | 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: Not defined

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **getUserInfoRoute**
> GetUserInfoResponse getUserInfoRoute()

Get user info

Returns user information compatible with the OpenID Connect Core 1.0 specification. Information returned depends on the requesting user as some data is only available if an app user profile exists.

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = AuthApi();

try {
    final result = api_instance.getUserInfoRoute();
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->getUserInfoRoute: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**GetUserInfoResponse**](GetUserInfoResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postChangePasswordRoute**
> PostLoginResponse postChangePasswordRoute(payload)

Change local user's password

After successful password change, all current access and refresh tokens are invalidated and a new set of auth tokens is returned

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = AuthApi();
final payload = PostChangePasswordPayload(); // PostChangePasswordPayload | 

try {
    final result = api_instance.postChangePasswordRoute(payload);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->postChangePasswordRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payload** | [**PostChangePasswordPayload**](PostChangePasswordPayload.md)|  | [optional] 

### Return type

[**PostLoginResponse**](PostLoginResponse.md)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postCompleteRegisterRoute**
> PostLoginResponse postCompleteRegisterRoute(registrationToken)

Complete registration

Completes registration for a local user

### Example
```dart
import 'package:spinsnitch_api/api.dart';

final api_instance = AuthApi();
final registrationToken = registrationToken_example; // String | Registration token to complete the registration process

try {
    final result = api_instance.postCompleteRegisterRoute(registrationToken);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->postCompleteRegisterRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **registrationToken** | **String**| Registration token to complete the registration process | 

### Return type

[**PostLoginResponse**](PostLoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postForgotPasswordCompleteRoute**
> PostLoginResponse postForgotPasswordCompleteRoute(payload)

Completes password reset for local user

Completes a password reset for a local user, using the password reset token sent via email to confirm user access, setting the new password if successful. All current access and refresh tokens are invalidated and a new set of auth tokens is returned

### Example
```dart
import 'package:spinsnitch_api/api.dart';

final api_instance = AuthApi();
final payload = PostForgotPasswordCompletePayload(); // PostForgotPasswordCompletePayload | 

try {
    final result = api_instance.postForgotPasswordCompleteRoute(payload);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->postForgotPasswordCompleteRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payload** | [**PostForgotPasswordCompletePayload**](PostForgotPasswordCompletePayload.md)|  | [optional] 

### Return type

[**PostLoginResponse**](PostLoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postForgotPasswordRoute**
> postForgotPasswordRoute(payload)

Initiate password reset for local user

Initiates a password reset for a local user, sending an email with a password reset link to the provided email address if a user account exists. Will always succeed, even if no user was found in order to prevent user enumeration

### Example
```dart
import 'package:spinsnitch_api/api.dart';

final api_instance = AuthApi();
final payload = PostForgotPasswordPayload(); // PostForgotPasswordPayload | 

try {
    api_instance.postForgotPasswordRoute(payload);
} catch (e) {
    print('Exception when calling AuthApi->postForgotPasswordRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payload** | [**PostForgotPasswordPayload**](PostForgotPasswordPayload.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postLoginRoute**
> PostLoginResponse postLoginRoute(payload)

Login with local user

Returns an access and refresh token on successful authentication

### Example
```dart
import 'package:spinsnitch_api/api.dart';

final api_instance = AuthApi();
final payload = PostLoginPayload(); // PostLoginPayload | 

try {
    final result = api_instance.postLoginRoute(payload);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->postLoginRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payload** | [**PostLoginPayload**](PostLoginPayload.md)|  | [optional] 

### Return type

[**PostLoginResponse**](PostLoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postLogoutRoute**
> postLogoutRoute(payload)

Log out local user

Logs the local user out, destroying the provided access token. A refresh token can optionally be provided, destroying it as well if found.

### Example
```dart
import 'package:spinsnitch_api/api.dart';
// TODO Configure API key authorization: Bearer
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKey = 'YOUR_API_KEY';
// uncomment below to setup prefix (e.g. Bearer) for API key, if needed
//defaultApiClient.getAuthentication<ApiKeyAuth>('Bearer').apiKeyPrefix = 'Bearer';

final api_instance = AuthApi();
final payload = PostLogoutPayload(); // PostLogoutPayload | 

try {
    api_instance.postLogoutRoute(payload);
} catch (e) {
    print('Exception when calling AuthApi->postLogoutRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payload** | [**PostLogoutPayload**](PostLogoutPayload.md)|  | [optional] 

### Return type

void (empty response body)

### Authorization

[Bearer](../README.md#Bearer)

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postRefreshRoute**
> PostLoginResponse postRefreshRoute(payload)

Refresh tokens

Returns a fresh set of access and refresh tokens if a valid refresh token was provided. The old refresh token used to authenticate the request will be invalidated.

### Example
```dart
import 'package:spinsnitch_api/api.dart';

final api_instance = AuthApi();
final payload = PostRefreshPayload(); // PostRefreshPayload | 

try {
    final result = api_instance.postRefreshRoute(payload);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->postRefreshRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payload** | [**PostRefreshPayload**](PostRefreshPayload.md)|  | [optional] 

### Return type

[**PostLoginResponse**](PostLoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **postRegisterRoute**
> PostLoginResponse postRegisterRoute(payload)

Registers a local user

Registers a local user. If the registration process requires a confirmation the status code `202` is returned without auth tokens. Afterwards the registration needs to be confirmed using the `POST /api/v1/auth/register/{registrationToken}` endpoint. 

### Example
```dart
import 'package:spinsnitch_api/api.dart';

final api_instance = AuthApi();
final payload = PostRegisterPayload(); // PostRegisterPayload | 

try {
    final result = api_instance.postRegisterRoute(payload);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->postRegisterRoute: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **payload** | [**PostRegisterPayload**](PostRegisterPayload.md)|  | [optional] 

### Return type

[**PostLoginResponse**](PostLoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

