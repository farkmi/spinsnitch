//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class OrderDir {
  /// Instantiate a new enum with the provided [value].
  const OrderDir._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const asc = OrderDir._(r'asc');
  static const desc = OrderDir._(r'desc');

  /// List of all possible values in this [enum][OrderDir].
  static const values = <OrderDir>[
    asc,
    desc,
  ];

  static OrderDir? fromJson(dynamic value) => OrderDirTypeTransformer().decode(value);

  static List<OrderDir> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <OrderDir>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = OrderDir.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [OrderDir] to String,
/// and [decode] dynamic data back to [OrderDir].
class OrderDirTypeTransformer {
  factory OrderDirTypeTransformer() => _instance ??= const OrderDirTypeTransformer._();

  const OrderDirTypeTransformer._();

  String encode(OrderDir data) => data.value;

  /// Decodes a [dynamic value][data] to a OrderDir.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  OrderDir? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data) {
        case r'asc': return OrderDir.asc;
        case r'desc': return OrderDir.desc;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [OrderDirTypeTransformer] instance.
  static OrderDirTypeTransformer? _instance;
}

