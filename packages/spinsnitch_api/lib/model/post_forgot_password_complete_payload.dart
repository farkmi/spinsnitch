//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostForgotPasswordCompletePayload {
  /// Returns a new [PostForgotPasswordCompletePayload] instance.
  PostForgotPasswordCompletePayload({
    required this.password,
    required this.token,
  });

  /// New password to set for user
  String password;

  /// Password reset token sent via email
  String token;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PostForgotPasswordCompletePayload &&
    other.password == password &&
    other.token == token;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (password.hashCode) +
    (token.hashCode);

  @override
  String toString() => 'PostForgotPasswordCompletePayload[password=$password, token=$token]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'password'] = this.password;
      json[r'token'] = this.token;
    return json;
  }

  /// Returns a new [PostForgotPasswordCompletePayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostForgotPasswordCompletePayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostForgotPasswordCompletePayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostForgotPasswordCompletePayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostForgotPasswordCompletePayload(
        password: mapValueOfType<String>(json, r'password')!,
        token: mapValueOfType<String>(json, r'token')!,
      );
    }
    return null;
  }

  static List<PostForgotPasswordCompletePayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostForgotPasswordCompletePayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostForgotPasswordCompletePayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostForgotPasswordCompletePayload> mapFromJson(dynamic json) {
    final map = <String, PostForgotPasswordCompletePayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostForgotPasswordCompletePayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostForgotPasswordCompletePayload-objects as value to a dart map
  static Map<String, List<PostForgotPasswordCompletePayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostForgotPasswordCompletePayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostForgotPasswordCompletePayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'password',
    'token',
  };
}

