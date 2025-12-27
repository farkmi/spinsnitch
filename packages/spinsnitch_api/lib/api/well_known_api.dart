//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class WellKnownApi {
  WellKnownApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Android Digital Asset Links
  ///
  /// Returns the Android Digital Asset Links file.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAndroidDigitalAssetLinksRouteWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/.well-known/assetlinks.json';

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

  /// Android Digital Asset Links
  ///
  /// Returns the Android Digital Asset Links file.
  Future<void> getAndroidDigitalAssetLinksRoute() async {
    final response = await getAndroidDigitalAssetLinksRouteWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Apple App Site Association
  ///
  /// Returns the Apple App Site Association file.
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getAppleAppSiteAssociationRouteWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/.well-known/apple-app-site-association';

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

  /// Apple App Site Association
  ///
  /// Returns the Apple App Site Association file.
  Future<void> getAppleAppSiteAssociationRoute() async {
    final response = await getAppleAppSiteAssociationRouteWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
