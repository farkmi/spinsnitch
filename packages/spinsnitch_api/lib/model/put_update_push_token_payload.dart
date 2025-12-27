//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PutUpdatePushTokenPayload {
  /// Returns a new [PutUpdatePushTokenPayload] instance.
  PutUpdatePushTokenPayload({
    required this.newToken,
    this.oldToken,
    required this.provider,
  });

  /// New push token for given provider.
  String newToken;

  /// Old token that can be deleted if present.
  String? oldToken;

  /// Identifier of the provider the token is for (eg. \"fcm\", \"apn\"). Currently only \"fcm\" is supported.
  String provider;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PutUpdatePushTokenPayload &&
    other.newToken == newToken &&
    other.oldToken == oldToken &&
    other.provider == provider;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (newToken.hashCode) +
    (oldToken == null ? 0 : oldToken!.hashCode) +
    (provider.hashCode);

  @override
  String toString() => 'PutUpdatePushTokenPayload[newToken=$newToken, oldToken=$oldToken, provider=$provider]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'newToken'] = this.newToken;
    if (this.oldToken != null) {
      json[r'oldToken'] = this.oldToken;
    } else {
      json[r'oldToken'] = null;
    }
      json[r'provider'] = this.provider;
    return json;
  }

  /// Returns a new [PutUpdatePushTokenPayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PutUpdatePushTokenPayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PutUpdatePushTokenPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PutUpdatePushTokenPayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PutUpdatePushTokenPayload(
        newToken: mapValueOfType<String>(json, r'newToken')!,
        oldToken: mapValueOfType<String>(json, r'oldToken'),
        provider: mapValueOfType<String>(json, r'provider')!,
      );
    }
    return null;
  }

  static List<PutUpdatePushTokenPayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PutUpdatePushTokenPayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PutUpdatePushTokenPayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PutUpdatePushTokenPayload> mapFromJson(dynamic json) {
    final map = <String, PutUpdatePushTokenPayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PutUpdatePushTokenPayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PutUpdatePushTokenPayload-objects as value to a dart map
  static Map<String, List<PutUpdatePushTokenPayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PutUpdatePushTokenPayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PutUpdatePushTokenPayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'newToken',
    'provider',
  };
}

