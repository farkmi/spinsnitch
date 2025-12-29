//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicHttpValidationError {
  /// Returns a new [PublicHttpValidationError] instance.
  PublicHttpValidationError({
    this.detail,
    required this.status,
    required this.title,
    required this.type,
    this.validationErrors = const [],
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

  /// List of errors received while validating payload against schema
  List<HttpValidationErrorDetail> validationErrors;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PublicHttpValidationError &&
    other.detail == detail &&
    other.status == status &&
    other.title == title &&
    other.type == type &&
    _deepEquality.equals(other.validationErrors, validationErrors);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (detail == null ? 0 : detail!.hashCode) +
    (status.hashCode) +
    (title.hashCode) +
    (type.hashCode) +
    (validationErrors.hashCode);

  @override
  String toString() => 'PublicHttpValidationError[detail=$detail, status=$status, title=$title, type=$type, validationErrors=$validationErrors]';

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
      json[r'validationErrors'] = this.validationErrors;
    return json;
  }

  /// Returns a new [PublicHttpValidationError] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicHttpValidationError? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PublicHttpValidationError[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PublicHttpValidationError[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PublicHttpValidationError(
        detail: mapValueOfType<String>(json, r'detail'),
        status: mapValueOfType<int>(json, r'status')!,
        title: mapValueOfType<String>(json, r'title')!,
        type: PublicHttpErrorType.fromJson(json[r'type'])!,
        validationErrors: HttpValidationErrorDetail.listFromJson(json[r'validationErrors']),
      );
    }
    return null;
  }

  static List<PublicHttpValidationError> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicHttpValidationError>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicHttpValidationError.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicHttpValidationError> mapFromJson(dynamic json) {
    final map = <String, PublicHttpValidationError>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicHttpValidationError.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicHttpValidationError-objects as value to a dart map
  static Map<String, List<PublicHttpValidationError>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PublicHttpValidationError>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicHttpValidationError.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'status',
    'title',
    'type',
    'validationErrors',
  };
}

