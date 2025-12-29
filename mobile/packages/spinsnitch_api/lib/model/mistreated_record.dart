//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MistreatedRecord {
  /// Returns a new [MistreatedRecord] instance.
  MistreatedRecord({
    this.artist,
    this.lastPlayed,
    this.neglectScore,
    this.sideLabel,
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
  DateTime? lastPlayed;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  double? neglectScore;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? sideLabel;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? title;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MistreatedRecord &&
    other.artist == artist &&
    other.lastPlayed == lastPlayed &&
    other.neglectScore == neglectScore &&
    other.sideLabel == sideLabel &&
    other.title == title;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (artist == null ? 0 : artist!.hashCode) +
    (lastPlayed == null ? 0 : lastPlayed!.hashCode) +
    (neglectScore == null ? 0 : neglectScore!.hashCode) +
    (sideLabel == null ? 0 : sideLabel!.hashCode) +
    (title == null ? 0 : title!.hashCode);

  @override
  String toString() => 'MistreatedRecord[artist=$artist, lastPlayed=$lastPlayed, neglectScore=$neglectScore, sideLabel=$sideLabel, title=$title]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.artist != null) {
      json[r'artist'] = this.artist;
    } else {
      json[r'artist'] = null;
    }
    if (this.lastPlayed != null) {
      json[r'lastPlayed'] = this.lastPlayed!.toUtc().toIso8601String();
    } else {
      json[r'lastPlayed'] = null;
    }
    if (this.neglectScore != null) {
      json[r'neglectScore'] = this.neglectScore;
    } else {
      json[r'neglectScore'] = null;
    }
    if (this.sideLabel != null) {
      json[r'sideLabel'] = this.sideLabel;
    } else {
      json[r'sideLabel'] = null;
    }
    if (this.title != null) {
      json[r'title'] = this.title;
    } else {
      json[r'title'] = null;
    }
    return json;
  }

  /// Returns a new [MistreatedRecord] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MistreatedRecord? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "MistreatedRecord[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "MistreatedRecord[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return MistreatedRecord(
        artist: mapValueOfType<String>(json, r'artist'),
        lastPlayed: mapDateTime(json, r'lastPlayed', r''),
        neglectScore: mapValueOfType<double>(json, r'neglectScore'),
        sideLabel: mapValueOfType<String>(json, r'sideLabel'),
        title: mapValueOfType<String>(json, r'title'),
      );
    }
    return null;
  }

  static List<MistreatedRecord> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MistreatedRecord>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MistreatedRecord.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MistreatedRecord> mapFromJson(dynamic json) {
    final map = <String, MistreatedRecord>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MistreatedRecord.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MistreatedRecord-objects as value to a dart map
  static Map<String, List<MistreatedRecord>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MistreatedRecord>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MistreatedRecord.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

