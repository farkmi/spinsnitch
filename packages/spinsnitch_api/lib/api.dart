//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

library openapi.api;

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

part 'api_client.dart';
part 'api_helper.dart';
part 'api_exception.dart';
part 'auth/authentication.dart';
part 'auth/api_key_auth.dart';
part 'auth/oauth.dart';
part 'auth/http_basic_auth.dart';
part 'auth/http_bearer_auth.dart';

part 'api/auth_api.dart';
part 'api/common_api.dart';
part 'api/push_api.dart';
part 'api/vinyl_api.dart';
part 'api/well_known_api.dart';

part 'model/delete_user_account_payload.dart';
part 'model/get_user_info_response.dart';
part 'model/http_validation_error_detail.dart';
part 'model/mistreated_record.dart';
part 'model/order_dir.dart';
part 'model/play_payload.dart';
part 'model/post_change_password_payload.dart';
part 'model/post_forgot_password_complete_payload.dart';
part 'model/post_forgot_password_payload.dart';
part 'model/post_login_payload.dart';
part 'model/post_login_response.dart';
part 'model/post_logout_payload.dart';
part 'model/post_refresh_payload.dart';
part 'model/post_register_payload.dart';
part 'model/post_vinyl_route200_response.dart';
part 'model/public_http_error.dart';
part 'model/public_http_error_type.dart';
part 'model/public_http_validation_error.dart';
part 'model/put_update_push_token_payload.dart';
part 'model/recent_plays_response.dart';
part 'model/recognition_result.dart';
part 'model/register_response.dart';
part 'model/track_play.dart';
part 'model/user_scope.dart';
part 'model/vinyl_payload.dart';
part 'model/vinyl_record.dart';
part 'model/vinyl_search_result.dart';


/// An [ApiClient] instance that uses the default values obtained from
/// the OpenAPI specification file.
var defaultApiClient = ApiClient();

const _delimiters = {'csv': ',', 'ssv': ' ', 'tsv': '\t', 'pipes': '|'};
const _dateEpochMarker = 'epoch';
const _deepEquality = DeepCollectionEquality();
final _dateFormatter = DateFormat('yyyy-MM-dd');
final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

bool _isEpochMarker(String? pattern) => pattern == _dateEpochMarker || pattern == '/$_dateEpochMarker/';
