//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

import 'package:spinsnitch_api/api.dart';
import 'package:test/test.dart';


/// tests for AuthApi
void main() {
  // final instance = AuthApi();

  group('tests for AuthApi', () {
    // Delete user account
    //
    // Completely delete the user account. This action is irreversible and therefore requires additional password authentication.
    //
    //Future deleteUserAccountRoute({ DeleteUserAccountPayload payload }) async
    test('test deleteUserAccountRoute', () async {
      // TODO
    });

    // Page to complete registration
    //
    //Future getCompleteRegisterRoute(String token) async
    test('test getCompleteRegisterRoute', () async {
      // TODO
    });

    // Get user info
    //
    // Returns user information compatible with the OpenID Connect Core 1.0 specification. Information returned depends on the requesting user as some data is only available if an app user profile exists.
    //
    //Future<GetUserInfoResponse> getUserInfoRoute() async
    test('test getUserInfoRoute', () async {
      // TODO
    });

    // Change local user's password
    //
    // After successful password change, all current access and refresh tokens are invalidated and a new set of auth tokens is returned
    //
    //Future<PostLoginResponse> postChangePasswordRoute({ PostChangePasswordPayload payload }) async
    test('test postChangePasswordRoute', () async {
      // TODO
    });

    // Complete registration
    //
    // Completes registration for a local user
    //
    //Future<PostLoginResponse> postCompleteRegisterRoute(String registrationToken) async
    test('test postCompleteRegisterRoute', () async {
      // TODO
    });

    // Completes password reset for local user
    //
    // Completes a password reset for a local user, using the password reset token sent via email to confirm user access, setting the new password if successful. All current access and refresh tokens are invalidated and a new set of auth tokens is returned
    //
    //Future<PostLoginResponse> postForgotPasswordCompleteRoute({ PostForgotPasswordCompletePayload payload }) async
    test('test postForgotPasswordCompleteRoute', () async {
      // TODO
    });

    // Initiate password reset for local user
    //
    // Initiates a password reset for a local user, sending an email with a password reset link to the provided email address if a user account exists. Will always succeed, even if no user was found in order to prevent user enumeration
    //
    //Future postForgotPasswordRoute({ PostForgotPasswordPayload payload }) async
    test('test postForgotPasswordRoute', () async {
      // TODO
    });

    // Login with local user
    //
    // Returns an access and refresh token on successful authentication
    //
    //Future<PostLoginResponse> postLoginRoute({ PostLoginPayload payload }) async
    test('test postLoginRoute', () async {
      // TODO
    });

    // Log out local user
    //
    // Logs the local user out, destroying the provided access token. A refresh token can optionally be provided, destroying it as well if found.
    //
    //Future postLogoutRoute({ PostLogoutPayload payload }) async
    test('test postLogoutRoute', () async {
      // TODO
    });

    // Refresh tokens
    //
    // Returns a fresh set of access and refresh tokens if a valid refresh token was provided. The old refresh token used to authenticate the request will be invalidated.
    //
    //Future<PostLoginResponse> postRefreshRoute({ PostRefreshPayload payload }) async
    test('test postRefreshRoute', () async {
      // TODO
    });

    // Registers a local user
    //
    // Registers a local user. If the registration process requires a confirmation the status code `202` is returned without auth tokens. Afterwards the registration needs to be confirmed using the `POST /api/v1/auth/register/{registrationToken}` endpoint. 
    //
    //Future<PostLoginResponse> postRegisterRoute({ PostRegisterPayload payload }) async
    test('test postRegisterRoute', () async {
      // TODO
    });

  });
}
