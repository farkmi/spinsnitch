//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class UserScope {
  /// Instantiate a new enum with the provided [value].
  const UserScope._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const app = UserScope._(r'app');
  static const cms = UserScope._(r'cms');

  /// List of all possible values in this [enum][UserScope].
  static const values = <UserScope>[
    app,
    cms,
  ];

  static UserScope? fromJson(dynamic value) => UserScopeTypeTransformer().decode(value);

  static List<UserScope> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <UserScope>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = UserScope.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [UserScope] to String,
/// and [decode] dynamic data back to [UserScope].
class UserScopeTypeTransformer {
  factory UserScopeTypeTransformer() => _instance ??= const UserScopeTypeTransformer._();

  const UserScopeTypeTransformer._();

  String encode(UserScope data) => data.value;

  /// Decodes a [dynamic value][data] to a UserScope.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  UserScope? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'app': return UserScope.app;
        case r'cms': return UserScope.cms;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [UserScopeTypeTransformer] instance.
  static UserScopeTypeTransformer? _instance;
}

