//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicHttpError {
  /// Returns a new [PublicHttpError] instance.
  PublicHttpError({
    this.detail,
    required this.status,
    required this.title,
    required this.type,
  });

  /// More detailed, human-readable, optional explanation of the error
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? detail;

  /// HTTP status code returned for the error
  ///
  /// Minimum value: 100
  /// Maximum value: 599
  int status;

  /// Short, human-readable description of the error
  String title;

  PublicHttpErrorType type;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PublicHttpError &&
    other.detail == detail &&
    other.status == status &&
    other.title == title &&
    other.type == type;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (detail == null ? 0 : detail!.hashCode) +
    (status.hashCode) +
    (title.hashCode) +
    (type.hashCode);

  @override
  String toString() => 'PublicHttpError[detail=$detail, status=$status, title=$title, type=$type]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.detail != null) {
      json[r'detail'] = this.detail;
    } else {
      json[r'detail'] = null;
    }
      json[r'status'] = this.status;
      json[r'title'] = this.title;
      json[r'type'] = this.type;
    return json;
  }

  /// Returns a new [PublicHttpError] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicHttpError? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PublicHttpError[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PublicHttpError[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PublicHttpError(
        detail: mapValueOfType<String>(json, r'detail'),
        status: mapValueOfType<int>(json, r'status')!,
        title: mapValueOfType<String>(json, r'title')!,
        type: PublicHttpErrorType.fromJson(json[r'type'])!,
      );
    }
    return null;
  }

  static List<PublicHttpError> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicHttpError>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicHttpError.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicHttpError> mapFromJson(dynamic json) {
    final map = <String, PublicHttpError>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicHttpError.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicHttpError-objects as value to a dart map
  static Map<String, List<PublicHttpError>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PublicHttpError>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicHttpError.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'status',
    'title',
    'type',
  };
}

