//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class VinylApi {
  VinylApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Get mistreated records
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMistreatedRouteWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/vinyls/mistreated';

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

  /// Get mistreated records
  Future<List<MistreatedRecord>?> getMistreatedRoute() async {
    final response = await getMistreatedRouteWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<MistreatedRecord>') as List)
        .cast<MistreatedRecord>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get recent track plays
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [int] limit:
  ///   Max number of plays to return
  Future<Response> getRecentPlaysRouteWithHttpInfo({ int? limit, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/vinyls/recent-plays';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (limit != null) {
      queryParams.addAll(_queryParams('', 'limit', limit));
    }

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

  /// Get recent track plays
  ///
  /// Parameters:
  ///
  /// * [int] limit:
  ///   Max number of plays to return
  Future<RecentPlaysResponse?> getRecentPlaysRoute({ int? limit, }) async {
    final response = await getRecentPlaysRouteWithHttpInfo( limit: limit, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RecentPlaysResponse',) as RecentPlaysResponse;
    
    }
    return null;
  }

  /// Search for vinyl records on Discogs
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] q (required):
  ///   Search query (artist, title, barcode)
  Future<Response> getVinylSearchRouteWithHttpInfo(String q,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/vinyls/search';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

      queryParams.addAll(_queryParams('', 'q', q));

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

  /// Search for vinyl records on Discogs
  ///
  /// Parameters:
  ///
  /// * [String] q (required):
  ///   Search query (artist, title, barcode)
  Future<List<VinylSearchResult>?> getVinylSearchRoute(String q,) async {
    final response = await getVinylSearchRouteWithHttpInfo(q,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<VinylSearchResult>') as List)
        .cast<VinylSearchResult>()
        .toList(growable: false);

    }
    return null;
  }

  /// List all vinyl records
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getVinylsRouteWithHttpInfo() async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/vinyls';

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

  /// List all vinyl records
  Future<List<VinylRecord>?> getVinylsRoute() async {
    final response = await getVinylsRouteWithHttpInfo();
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<VinylRecord>') as List)
        .cast<VinylRecord>()
        .toList(growable: false);

    }
    return null;
  }

  /// Register a play
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PlayPayload] payload:
  Future<Response> postPlayRouteWithHttpInfo({ PlayPayload? payload, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/vinyls/play';

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

  /// Register a play
  ///
  /// Parameters:
  ///
  /// * [PlayPayload] payload:
  Future<void> postPlayRoute({ PlayPayload? payload, }) async {
    final response = await postPlayRouteWithHttpInfo( payload: payload, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Recognize a music snippet
  ///
  /// Upload an audio snippet to identify the music.
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  Future<Response> postRecognizeRouteWithHttpInfo(MultipartFile file,) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/vinyls/recognize';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['multipart/form-data'];

    bool hasFields = false;
    final mp = MultipartRequest('POST', Uri.parse(path));
    if (file != null) {
      hasFields = true;
      mp.fields[r'file'] = file.field;
      mp.files.add(file);
    }
    if (hasFields) {
      postBody = mp;
    }

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

  /// Recognize a music snippet
  ///
  /// Upload an audio snippet to identify the music.
  ///
  /// Parameters:
  ///
  /// * [MultipartFile] file (required):
  Future<RecognitionResult?> postRecognizeRoute(MultipartFile file,) async {
    final response = await postRecognizeRouteWithHttpInfo(file,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RecognitionResult',) as RecognitionResult;
    
    }
    return null;
  }

  /// Add a new vinyl record
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [VinylPayload] payload:
  Future<Response> postVinylRouteWithHttpInfo({ VinylPayload? payload, }) async {
    // ignore: prefer_const_declarations
    final path = r'/api/v1/vinyls';

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

  /// Add a new vinyl record
  ///
  /// Parameters:
  ///
  /// * [VinylPayload] payload:
  Future<PostVinylRoute200Response?> postVinylRoute({ VinylPayload? payload, }) async {
    final response = await postVinylRouteWithHttpInfo( payload: payload, );
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PostVinylRoute200Response',) as PostVinylRoute200Response;
    
    }
    return null;
  }
}
