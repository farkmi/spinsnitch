//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PostVinylRoute200Response {
  /// Returns a new [PostVinylRoute200Response] instance.
  PostVinylRoute200Response({
    required this.artist,
    this.coverImage,
    this.createdAt,
    required this.discogsId,
    this.genres = const [],
    required this.id,
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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? createdAt;

  int discogsId;

  List<String> genres;

  int id;

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
  bool operator ==(Object other) => identical(this, other) || other is PostVinylRoute200Response &&
    other.artist == artist &&
    other.coverImage == coverImage &&
    other.createdAt == createdAt &&
    other.discogsId == discogsId &&
    _deepEquality.equals(other.genres, genres) &&
    other.id == id &&
    _deepEquality.equals(other.styles, styles) &&
    other.thumbImage == thumbImage &&
    other.title == title &&
    other.year == year;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (artist.hashCode) +
    (coverImage == null ? 0 : coverImage!.hashCode) +
    (createdAt == null ? 0 : createdAt!.hashCode) +
    (discogsId.hashCode) +
    (genres.hashCode) +
    (id.hashCode) +
    (styles.hashCode) +
    (thumbImage == null ? 0 : thumbImage!.hashCode) +
    (title.hashCode) +
    (year == null ? 0 : year!.hashCode);

  @override
  String toString() => 'PostVinylRoute200Response[artist=$artist, coverImage=$coverImage, createdAt=$createdAt, discogsId=$discogsId, genres=$genres, id=$id, styles=$styles, thumbImage=$thumbImage, title=$title, year=$year]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'artist'] = this.artist;
    if (this.coverImage != null) {
      json[r'coverImage'] = this.coverImage;
    } else {
      json[r'coverImage'] = null;
    }
    if (this.createdAt != null) {
      json[r'createdAt'] = this.createdAt!.toUtc().toIso8601String();
    } else {
      json[r'createdAt'] = null;
    }
      json[r'discogsId'] = this.discogsId;
      json[r'genres'] = this.genres;
      json[r'id'] = this.id;
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

  /// Returns a new [PostVinylRoute200Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PostVinylRoute200Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "PostVinylRoute200Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "PostVinylRoute200Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return PostVinylRoute200Response(
        artist: mapValueOfType<String>(json, r'artist')!,
        coverImage: mapValueOfType<String>(json, r'coverImage'),
        createdAt: mapDateTime(json, r'createdAt', r''),
        discogsId: mapValueOfType<int>(json, r'discogsId')!,
        genres: json[r'genres'] is Iterable
            ? (json[r'genres'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        id: mapValueOfType<int>(json, r'id')!,
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

  static List<PostVinylRoute200Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PostVinylRoute200Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PostVinylRoute200Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PostVinylRoute200Response> mapFromJson(dynamic json) {
    final map = <String, PostVinylRoute200Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PostVinylRoute200Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PostVinylRoute200Response-objects as value to a dart map
  static Map<String, List<PostVinylRoute200Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PostVinylRoute200Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PostVinylRoute200Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'artist',
    'discogsId',
    'id',
    'title',
  };
}

