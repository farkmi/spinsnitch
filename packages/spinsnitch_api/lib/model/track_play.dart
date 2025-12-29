//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TrackPlay {
  /// Returns a new [TrackPlay] instance.
  TrackPlay({
    this.artist,
    this.id,
    this.playedAt,
    this.title,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? artist;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? playedAt;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? title;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TrackPlay &&
    other.artist == artist &&
    other.id == id &&
    other.playedAt == playedAt &&
    other.title == title;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (artist == null ? 0 : artist!.hashCode) +
    (id == null ? 0 : id!.hashCode) +
    (playedAt == null ? 0 : playedAt!.hashCode) +
    (title == null ? 0 : title!.hashCode);

  @override
  String toString() => 'TrackPlay[artist=$artist, id=$id, playedAt=$playedAt, title=$title]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.artist != null) {
      json[r'artist'] = this.artist;
    } else {
      json[r'artist'] = null;
    }
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.playedAt != null) {
      json[r'playedAt'] = this.playedAt!.toUtc().toIso8601String();
    } else {
      json[r'playedAt'] = null;
    }
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    return json;
  }

  /// Returns a new [TrackPlay] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TrackPlay? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TrackPlay[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TrackPlay[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TrackPlay(
        artist: mapValueOfType<String>(json, r'artist'),
        id: mapValueOfType<int>(json, r'id'),
        playedAt: mapDateTime(json, r'playedAt', r''),
        title: mapValueOfType<String>(json, r'title'),
      );
    }
    return null;
  }

  static List<TrackPlay> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TrackPlay>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TrackPlay.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TrackPlay> mapFromJson(dynamic json) {
    final map = <String, TrackPlay>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TrackPlay.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TrackPlay-objects as value to a dart map
  static Map<String, List<TrackPlay>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TrackPlay>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TrackPlay.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

