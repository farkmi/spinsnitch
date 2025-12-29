//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class VinylSearchResult {
  /// Returns a new [VinylSearchResult] instance.
  VinylSearchResult({
    required this.artist,
    this.coverImage,
    required this.discogsId,
    this.genres = const [],
    this.styles = const [],
    this.thumbImage,
    required this.title,
    this.year,
  });

  String artist;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? coverImage;

  int discogsId;

  List<String> genres;

  List<String> styles;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? thumbImage;

  String title;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? year;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VinylSearchResult &&
    other.artist == artist &&
    other.coverImage == coverImage &&
    other.discogsId == discogsId &&
    _deepEquality.equals(other.genres, genres) &&
    _deepEquality.equals(other.styles, styles) &&
    other.thumbImage == thumbImage &&
    other.title == title &&
    other.year == year;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (artist.hashCode) +
    (coverImage == null ? 0 : coverImage!.hashCode) +
    (discogsId.hashCode) +
    (genres.hashCode) +
    (styles.hashCode) +
    (thumbImage == null ? 0 : thumbImage!.hashCode) +
    (title.hashCode) +
    (year == null ? 0 : year!.hashCode);

  @override
  String toString() => 'VinylSearchResult[artist=$artist, coverImage=$coverImage, discogsId=$discogsId, genres=$genres, styles=$styles, thumbImage=$thumbImage, title=$title, year=$year]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'artist'] = this.artist;
    if (this.coverImage != null) {
      json[r'coverImage'] = this.coverImage;
    } else {
      json[r'coverImage'] = null;
    }
      json[r'discogsId'] = this.discogsId;
      json[r'genres'] = this.genres;
      json[r'styles'] = this.styles;
    if (this.thumbImage != null) {
      json[r'thumbImage'] = this.thumbImage;
    } else {
      json[r'thumbImage'] = null;
    }
      json[r'title'] = this.title;
    if (this.year != null) {
      json[r'year'] = this.year;
    } else {
      json[r'year'] = null;
    }
    return json;
  }

  /// Returns a new [VinylSearchResult] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VinylSearchResult? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "VinylSearchResult[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "VinylSearchResult[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return VinylSearchResult(
        artist: mapValueOfType<String>(json, r'artist')!,
        coverImage: mapValueOfType<String>(json, r'coverImage'),
        discogsId: mapValueOfType<int>(json, r'discogsId')!,
        genres: json[r'genres'] is Iterable
            ? (json[r'genres'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        styles: json[r'styles'] is Iterable
            ? (json[r'styles'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        thumbImage: mapValueOfType<String>(json, r'thumbImage'),
        title: mapValueOfType<String>(json, r'title')!,
        year: mapValueOfType<int>(json, r'year'),
      );
    }
    return null;
  }

  static List<VinylSearchResult> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VinylSearchResult>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VinylSearchResult.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VinylSearchResult> mapFromJson(dynamic json) {
    final map = <String, VinylSearchResult>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VinylSearchResult.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VinylSearchResult-objects as value to a dart map
  static Map<String, List<VinylSearchResult>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VinylSearchResult>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VinylSearchResult.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'artist',
    'discogsId',
    'title',
  };
}

