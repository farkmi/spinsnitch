//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AuthApi {
  AuthApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Delete user account
  ///
  /// Completely delete the user account. This action is irreversible and therefore requires additional password authentication.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DeleteUserAccountPayload] payload:
  Future<Response> deleteUserAccountRouteWithHttpInfo({ DeleteUserAccountPayload? payload, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/auth/account';

    // ignore: prefer_final_locals
    Object? postBody = payload;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Delete user account
  ///
  /// Completely delete the user account. This action is irreversible and therefore requires additional password authentication.
  ///
  /// Parameters:
  ///
  /// * [DeleteUserAccountPayload] payload:
  Future<void> deleteUserAccountRoute({ DeleteUserAccountPayload? payload, }) async {
    final response = await deleteUserAccountRouteWithHttpInfo( payload: payload, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Page to complete registration
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] token (required):
  ///   Registration token to complete the registration process
  Future<Response> getCompleteRegisterRouteWithHttpInfo(String token,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/auth/register';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'token', token));

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

  /// Page to complete registration
  ///
  /// Parameters:
  ///
  /// * [String] token (required):
  ///   Registration token to complete the registration process
  Future<void> getCompleteRegisterRoute(String token,) async {
    final response = await getCompleteRegisterRouteWithHttpInfo(token,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Get user info
  ///
  /// Returns user information compatible with the OpenID Connect Core 1.0 specification. Information returned depends on the requesting user as some data is only available if an app user profile exists.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getUserInfoRouteWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/auth/userinfo';

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

  /// Get user info
  ///
  /// Returns user information compatible with the OpenID Connect Core 1.0 specification. Information returned depends on the requesting user as some data is only available if an app user profile exists.
  Future<GetUserInfoResponse?> getUserInfoRoute() async {
    final response = await getUserInfoRouteWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'GetUserInfoResponse',) as GetUserInfoResponse;
    
    }
    return null;
  }

  /// Change local user's password
  ///
  /// After successful password change, all current access and refresh tokens are invalidated and a new set of auth tokens is returned
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostChangePasswordPayload] payload:
  Future<Response> postChangePasswordRouteWithHttpInfo({ PostChangePasswordPayload? payload, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/auth/change-password';

    // ignore: prefer_final_locals
    Object? postBody = payload;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Change local user's password
  ///
  /// After successful password change, all current access and refresh tokens are invalidated and a new set of auth tokens is returned
  ///
  /// Parameters:
  ///
  /// * [PostChangePasswordPayload] payload:
  Future<PostLoginResponse?> postChangePasswordRoute({ PostChangePasswordPayload? payload, }) async {
    final response = await postChangePasswordRouteWithHttpInfo( payload: payload, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PostLoginResponse',) as PostLoginResponse;
    
    }
    return null;
  }

  /// Complete registration
  ///
  /// Completes registration for a local user
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] registrationToken (required):
  ///   Registration token to complete the registration process
  Future<Response> postCompleteRegisterRouteWithHttpInfo(String registrationToken,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/auth/register/{registrationToken}'
      .replaceAll('{registrationToken}', registrationToken);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Complete registration
  ///
  /// Completes registration for a local user
  ///
  /// Parameters:
  ///
  /// * [String] registrationToken (required):
  ///   Registration token to complete the registration process
  Future<PostLoginResponse?> postCompleteRegisterRoute(String registrationToken,) async {
    final response = await postCompleteRegisterRouteWithHttpInfo(registrationToken,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PostLoginResponse',) as PostLoginResponse;
    
    }
    return null;
  }

  /// Completes password reset for local user
  ///
  /// Completes a password reset for a local user, using the password reset token sent via email to confirm user access, setting the new password if successful. All current access and refresh tokens are invalidated and a new set of auth tokens is returned
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostForgotPasswordCompletePayload] payload:
  Future<Response> postForgotPasswordCompleteRouteWithHttpInfo({ PostForgotPasswordCompletePayload? payload, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/auth/forgot-password/complete';

    // ignore: prefer_final_locals
    Object? postBody = payload;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Completes password reset for local user
  ///
  /// Completes a password reset for a local user, using the password reset token sent via email to confirm user access, setting the new password if successful. All current access and refresh tokens are invalidated and a new set of auth tokens is returned
  ///
  /// Parameters:
  ///
  /// * [PostForgotPasswordCompletePayload] payload:
  Future<PostLoginResponse?> postForgotPasswordCompleteRoute({ PostForgotPasswordCompletePayload? payload, }) async {
    final response = await postForgotPasswordCompleteRouteWithHttpInfo( payload: payload, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PostLoginResponse',) as PostLoginResponse;
    
    }
    return null;
  }

  /// Initiate password reset for local user
  ///
  /// Initiates a password reset for a local user, sending an email with a password reset link to the provided email address if a user account exists. Will always succeed, even if no user was found in order to prevent user enumeration
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostForgotPasswordPayload] payload:
  Future<Response> postForgotPasswordRouteWithHttpInfo({ PostForgotPasswordPayload? payload, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/auth/forgot-password';

    // ignore: prefer_final_locals
    Object? postBody = payload;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Initiate password reset for local user
  ///
  /// Initiates a password reset for a local user, sending an email with a password reset link to the provided email address if a user account exists. Will always succeed, even if no user was found in order to prevent user enumeration
  ///
  /// Parameters:
  ///
  /// * [PostForgotPasswordPayload] payload:
  Future<void> postForgotPasswordRoute({ PostForgotPasswordPayload? payload, }) async {
    final response = await postForgotPasswordRouteWithHttpInfo( payload: payload, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Login with local user
  ///
  /// Returns an access and refresh token on successful authentication
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostLoginPayload] payload:
  Future<Response> postLoginRouteWithHttpInfo({ PostLoginPayload? payload, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/auth/login';

    // ignore: prefer_final_locals
    Object? postBody = payload;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Login with local user
  ///
  /// Returns an access and refresh token on successful authentication
  ///
  /// Parameters:
  ///
  /// * [PostLoginPayload] payload:
  Future<PostLoginResponse?> postLoginRoute({ PostLoginPayload? payload, }) async {
    final response = await postLoginRouteWithHttpInfo( payload: payload, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PostLoginResponse',) as PostLoginResponse;
    
    }
    return null;
  }

  /// Log out local user
  ///
  /// Logs the local user out, destroying the provided access token. A refresh token can optionally be provided, destroying it as well if found.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostLogoutPayload] payload:
  Future<Response> postLogoutRouteWithHttpInfo({ PostLogoutPayload? payload, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/auth/logout';

    // ignore: prefer_final_locals
    Object? postBody = payload;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Log out local user
  ///
  /// Logs the local user out, destroying the provided access token. A refresh token can optionally be provided, destroying it as well if found.
  ///
  /// Parameters:
  ///
  /// * [PostLogoutPayload] payload:
  Future<void> postLogoutRoute({ PostLogoutPayload? payload, }) async {
    final response = await postLogoutRouteWithHttpInfo( payload: payload, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Refresh tokens
  ///
  /// Returns a fresh set of access and refresh tokens if a valid refresh token was provided. The old refresh token used to authenticate the request will be invalidated.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostRefreshPayload] payload:
  Future<Response> postRefreshRouteWithHttpInfo({ PostRefreshPayload? payload, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/auth/refresh';

    // ignore: prefer_final_locals
    Object? postBody = payload;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Refresh tokens
  ///
  /// Returns a fresh set of access and refresh tokens if a valid refresh token was provided. The old refresh token used to authenticate the request will be invalidated.
  ///
  /// Parameters:
  ///
  /// * [PostRefreshPayload] payload:
  Future<PostLoginResponse?> postRefreshRoute({ PostRefreshPayload? payload, }) async {
    final response = await postRefreshRouteWithHttpInfo( payload: payload, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PostLoginResponse',) as PostLoginResponse;
    
    }
    return null;
  }

  /// Registers a local user
  ///
  /// Registers a local user. If the registration process requires a confirmation the status code `202` is returned without auth tokens. Afterwards the registration needs to be confirmed using the `POST /api/v1/auth/register/{registrationToken}` endpoint. 
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PostRegisterPayload] payload:
  Future<Response> postRegisterRouteWithHttpInfo({ PostRegisterPayload? payload, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/auth/register';

    // ignore: prefer_final_locals
    Object? postBody = payload;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Registers a local user
  ///
  /// Registers a local user. If the registration process requires a confirmation the status code `202` is returned without auth tokens. Afterwards the registration needs to be confirmed using the `POST /api/v1/auth/register/{registrationToken}` endpoint. 
  ///
  /// Parameters:
  ///
  /// * [PostRegisterPayload] payload:
  Future<PostLoginResponse?> postRegisterRoute({ PostRegisterPayload? payload, }) async {
    final response = await postRegisterRouteWithHttpInfo( payload: payload, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PostLoginResponse',) as PostLoginResponse;
    
    }
    return null;
  }
}
