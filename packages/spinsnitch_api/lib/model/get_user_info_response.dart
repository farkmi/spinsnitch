//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class GetUserInfoResponse {
  /// Returns a new [GetUserInfoResponse] instance.
  GetUserInfoResponse({
    this.email,
    this.scopes = const [],
    required this.sub,
    required this.updatedAt,
  });

  /// Email address of user, if available
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? email;

  /// Auth-Scopes of the user, if available
  List<UserScope> scopes;

  /// ID of user
  String sub;

  /// Unix timestamp the user's info was last updated at
  int updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is GetUserInfoResponse &&
    other.email == email &&
    _deepEquality.equals(other.scopes, scopes) &&
    other.sub == sub &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email == null ? 0 : email!.hashCode) +
    (scopes.hashCode) +
    (sub.hashCode) +
    (updatedAt.hashCode);

  @override
  String toString() => 'GetUserInfoResponse[email=$email, scopes=$scopes, sub=$sub, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
      json[r'scopes'] = this.scopes;
      json[r'sub'] = this.sub;
      json[r'updated_at'] = this.updatedAt;
    return json;
  }

  /// Returns a new [GetUserInfoResponse] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static GetUserInfoResponse? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "GetUserInfoResponse[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "GetUserInfoResponse[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return GetUserInfoResponse(
        email: mapValueOfType<String>(json, r'email'),
        scopes: UserScope.listFromJson(json[r'scopes']),
        sub: mapValueOfType<String>(json, r'sub')!,
        updatedAt: mapValueOfType<int>(json, r'updated_at')!,
      );
    }
    return null;
  }

  static List<GetUserInfoResponse> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <GetUserInfoResponse>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = GetUserInfoResponse.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, GetUserInfoResponse> mapFromJson(dynamic json) {
    final map = <String, GetUserInfoResponse>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = GetUserInfoResponse.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of GetUserInfoResponse-objects as value to a dart map
  static Map<String, List<GetUserInfoResponse>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<GetUserInfoResponse>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = GetUserInfoResponse.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'sub',
    'updated_at',
  };
}

