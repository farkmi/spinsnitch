//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class PushApi {
  PushApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Adds a push token to the user
  ///
  /// Adds a push token for the given provider to the current user. If the oldToken is present it will be deleted. Currently only the provider 'fcm' is supported.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PutUpdatePushTokenPayload] payload:
  Future<Response> putUpdatePushTokenRouteWithHttpInfo({ PutUpdatePushTokenPayload? payload, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/push/token';

    // ignore: prefer_final_locals
    Object? postBody = payload;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Adds a push token to the user
  ///
  /// Adds a push token for the given provider to the current user. If the oldToken is present it will be deleted. Currently only the provider 'fcm' is supported.
  ///
  /// Parameters:
  ///
  /// * [PutUpdatePushTokenPayload] payload:
  Future<void> putUpdatePushTokenRoute({ PutUpdatePushTokenPayload? payload, }) async {
    final response = await putUpdatePushTokenRouteWithHttpInfo( payload: payload, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
