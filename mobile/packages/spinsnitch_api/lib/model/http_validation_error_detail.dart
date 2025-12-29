//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class HttpValidationErrorDetail {
  /// Returns a new [HttpValidationErrorDetail] instance.
  HttpValidationErrorDetail({
    required this.error,
    required this.in_,
    required this.key,
  });

  /// Error describing field validation failure
  String error;

  /// Indicates how the invalid field was provided
  String in_;

  /// Key of field failing validation
  String key;

  @override
  bool operator ==(Object other) => identical(this, other) || other is HttpValidationErrorDetail &&
    other.error == error &&
    other.in_ == in_ &&
    other.key == key;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (error.hashCode) +
    (in_.hashCode) +
    (key.hashCode);

  @override
  String toString() => 'HttpValidationErrorDetail[error=$error, in_=$in_, key=$key]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'error'] = this.error;
      json[r'in'] = this.in_;
      json[r'key'] = this.key;
    return json;
  }

  /// Returns a new [HttpValidationErrorDetail] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static HttpValidationErrorDetail? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "HttpValidationErrorDetail[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "HttpValidationErrorDetail[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return HttpValidationErrorDetail(
        error: mapValueOfType<String>(json, r'error')!,
        in_: mapValueOfType<String>(json, r'in')!,
        key: mapValueOfType<String>(json, r'key')!,
      );
    }
    return null;
  }

  static List<HttpValidationErrorDetail> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <HttpValidationErrorDetail>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = HttpValidationErrorDetail.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, HttpValidationErrorDetail> mapFromJson(dynamic json) {
    final map = <String, HttpValidationErrorDetail>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = HttpValidationErrorDetail.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of HttpValidationErrorDetail-objects as value to a dart map
  static Map<String, List<HttpValidationErrorDetail>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<HttpValidationErrorDetail>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = HttpValidationErrorDetail.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'error',
    'in',
    'key',
  };
}

