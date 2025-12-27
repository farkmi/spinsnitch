//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PlayPayload {
  /// Returns a new [PlayPayload] instance.
  PlayPayload({
    required this.artist,
    required this.title,
  });

  String artist;

  String title;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PlayPayload &&
    other.artist == artist &&
    other.title == title;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (artist.hashCode) +
    (title.hashCode);

  @override
  String toString() => 'PlayPayload[artist=$artist, title=$title]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'artist'] = this.artist;
      json[r'title'] = this.title;
    return json;
  }

  /// Returns a new [PlayPayload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PlayPayload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PlayPayload[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PlayPayload[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PlayPayload(
        artist: mapValueOfType<String>(json, r'artist')!,
        title: mapValueOfType<String>(json, r'title')!,
      );
    }
    return null;
  }

  static List<PlayPayload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PlayPayload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PlayPayload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PlayPayload> mapFromJson(dynamic json) {
    final map = <String, PlayPayload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PlayPayload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PlayPayload-objects as value to a dart map
  static Map<String, List<PlayPayload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PlayPayload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PlayPayload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'artist',
    'title',
  };
}

