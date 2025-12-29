//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// Type of error returned, should be used for client-side error handling
class PublicHttpErrorType {
  /// Instantiate a new enum with the provided [value].
  const PublicHttpErrorType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const generic = PublicHttpErrorType._(r'generic');
  static const PUSH_TOKEN_ALREADY_EXISTS = PublicHttpErrorType._(r'PUSH_TOKEN_ALREADY_EXISTS');
  static const OLD_PUSH_TOKEN_NOT_FOUND = PublicHttpErrorType._(r'OLD_PUSH_TOKEN_NOT_FOUND');
  static const ZERO_FILE_SIZE = PublicHttpErrorType._(r'ZERO_FILE_SIZE');
  static const USER_DEACTIVATED = PublicHttpErrorType._(r'USER_DEACTIVATED');
  static const INVALID_PASSWORD = PublicHttpErrorType._(r'INVALID_PASSWORD');
  static const NOT_LOCAL_USER = PublicHttpErrorType._(r'NOT_LOCAL_USER');
  static const TOKEN_NOT_FOUND = PublicHttpErrorType._(r'TOKEN_NOT_FOUND');
  static const TOKEN_EXPIRED = PublicHttpErrorType._(r'TOKEN_EXPIRED');
  static const USER_ALREADY_EXISTS = PublicHttpErrorType._(r'USER_ALREADY_EXISTS');
  static const MALFORMED_TOKEN = PublicHttpErrorType._(r'MALFORMED_TOKEN');
  static const LAST_AUTHENTICATED_AT_EXCEEDED = PublicHttpErrorType._(r'LAST_AUTHENTICATED_AT_EXCEEDED');
  static const MISSING_SCOPES = PublicHttpErrorType._(r'MISSING_SCOPES');

  /// List of all possible values in this [enum][PublicHttpErrorType].
  static const values = <PublicHttpErrorType>[
    generic,
    PUSH_TOKEN_ALREADY_EXISTS,
    OLD_PUSH_TOKEN_NOT_FOUND,
    ZERO_FILE_SIZE,
    USER_DEACTIVATED,
    INVALID_PASSWORD,
    NOT_LOCAL_USER,
    TOKEN_NOT_FOUND,
    TOKEN_EXPIRED,
    USER_ALREADY_EXISTS,
    MALFORMED_TOKEN,
    LAST_AUTHENTICATED_AT_EXCEEDED,
    MISSING_SCOPES,
  ];

  static PublicHttpErrorType? fromJson(dynamic value) => PublicHttpErrorTypeTypeTransformer().decode(value);

  static List<PublicHttpErrorType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicHttpErrorType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicHttpErrorType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PublicHttpErrorType] to String,
/// and [decode] dynamic data back to [PublicHttpErrorType].
class PublicHttpErrorTypeTypeTransformer {
  factory PublicHttpErrorTypeTypeTransformer() => _instance ??= const PublicHttpErrorTypeTypeTransformer._();

  const PublicHttpErrorTypeTypeTransformer._();

  String encode(PublicHttpErrorType data) => data.value;

  /// Decodes a [dynamic value][data] to a PublicHttpErrorType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PublicHttpErrorType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'generic': return PublicHttpErrorType.generic;
        case r'PUSH_TOKEN_ALREADY_EXISTS': return PublicHttpErrorType.PUSH_TOKEN_ALREADY_EXISTS;
        case r'OLD_PUSH_TOKEN_NOT_FOUND': return PublicHttpErrorType.OLD_PUSH_TOKEN_NOT_FOUND;
        case r'ZERO_FILE_SIZE': return PublicHttpErrorType.ZERO_FILE_SIZE;
        case r'USER_DEACTIVATED': return PublicHttpErrorType.USER_DEACTIVATED;
        case r'INVALID_PASSWORD': return PublicHttpErrorType.INVALID_PASSWORD;
        case r'NOT_LOCAL_USER': return PublicHttpErrorType.NOT_LOCAL_USER;
        case r'TOKEN_NOT_FOUND': return PublicHttpErrorType.TOKEN_NOT_FOUND;
        case r'TOKEN_EXPIRED': return PublicHttpErrorType.TOKEN_EXPIRED;
        case r'USER_ALREADY_EXISTS': return PublicHttpErrorType.USER_ALREADY_EXISTS;
        case r'MALFORMED_TOKEN': return PublicHttpErrorType.MALFORMED_TOKEN;
        case r'LAST_AUTHENTICATED_AT_EXCEEDED': return PublicHttpErrorType.LAST_AUTHENTICATED_AT_EXCEEDED;
        case r'MISSING_SCOPES': return PublicHttpErrorType.MISSING_SCOPES;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [PublicHttpErrorTypeTypeTransformer] instance.
  static PublicHttpErrorTypeTypeTransformer? _instance;
}

