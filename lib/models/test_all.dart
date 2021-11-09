import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';

import 'product.dart';


@immutable
class TestAll {

  const TestAll({
    required this.id,
    required this.message,
    required this.product,
    required this.strList,
    required this.intList,
    required this.doubleList,
    required this.boolList,
    required this.startTime,
    this.type,
    this.point,
    this.customKey,
  });

  final int id;
  final String message;
  final Product product;
  final List<String> strList;
  final List<int> intList;
  final List<double> doubleList;
  final List<bool> boolList;
  final DateTime startTime;
  TestAllTypeEnum? get testAllTypeEnum => _testAllTypeEnumValues.map[type];
  final String? type;
  final Point? point;
  final String? customKey;

  factory TestAll.fromJson(Map<String,dynamic> json) => TestAll(
    id: json['id'] as int,
    message: json['message'] as String,
    product: Product.fromJson(json['product'] as Map<String, dynamic>),
    strList: (json['strList'] as List? ?? []).map((e) => e as String).toList(),
    intList: (json['intList'] as List? ?? []).map((e) => e as int).toList(),
    doubleList: (json['doubleList'] as List? ?? []).map((e) => e as double).toList(),
    boolList: (json['boolList'] as List? ?? []).map((e) => e as bool).toList(),
    startTime: DateTime.parse(json['startTime'] as String),
    type: json['type'] != null ? json['type'] as String : null,
    point: json['point'] != null ? Point.fromJson(json['point'] as Map<String, dynamic>) : null
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'message': message,
    'product': product.toJson(),
    'strList': strList.map((e) => e.toString()).toList(),
    'intList': intList.map((e) => e.toString()).toList(),
    'doubleList': doubleList.map((e) => e.toString()).toList(),
    'boolList': boolList.map((e) => e.toString()).toList(),
    'startTime': startTime.toIso8601String(),
    'type': type,
    'point': point?.toJson()
  };

  TestAll clone() => TestAll(
    id: id,
    message: message,
    product: product.clone(),
    strList: strList.toList(),
    intList: intList.toList(),
    doubleList: doubleList.toList(),
    boolList: boolList.toList(),
    startTime: startTime,
    type: type,
    point: point?.clone(),
    customKey: customKey
  );


  TestAll copyWith({
    int? id,
    String? message,
    Product? product,
    List<String>? strList,
    List<int>? intList,
    List<double>? doubleList,
    List<bool>? boolList,
    DateTime? startTime,
    Optional<String?>? type,
    Optional<Point?>? point,
    Optional<String?>? customKey
  }) => TestAll(
    id: id ?? this.id,
    message: message ?? this.message,
    product: product ?? this.product,
    strList: strList ?? this.strList,
    intList: intList ?? this.intList,
    doubleList: doubleList ?? this.doubleList,
    boolList: boolList ?? this.boolList,
    startTime: startTime ?? this.startTime,
    type: checkOptional(type, this.type),
    point: checkOptional(point, this.point),
    customKey: checkOptional(customKey, this.customKey),
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is TestAll && id == other.id && message == other.message && product == other.product && strList == other.strList && intList == other.intList && doubleList == other.doubleList && boolList == other.boolList && startTime == other.startTime && type == other.type && point == other.point && customKey == other.customKey;

  @override
  int get hashCode => id.hashCode ^ message.hashCode ^ product.hashCode ^ strList.hashCode ^ intList.hashCode ^ doubleList.hashCode ^ boolList.hashCode ^ startTime.hashCode ^ type.hashCode ^ point.hashCode ^ customKey.hashCode;
}

enum TestAllTypeEnum { INSIDE, OUTSIDE, CLIENT, HOME, ROOM, UNKNOWN }

extension TestAllTypeEnumEx on TestAllTypeEnum{
  String? get value => _testAllTypeEnumValues.reverse[this];
}

final _testAllTypeEnumValues = _TestAllTypeEnumConverter({
  'INSIDE': TestAllTypeEnum.INSIDE,
  'OUTSIDE': TestAllTypeEnum.OUTSIDE,
  'CLIENT': TestAllTypeEnum.CLIENT,
  'HOME': TestAllTypeEnum.HOME,
  'ROOM': TestAllTypeEnum.ROOM,
  'UNKNOWN': TestAllTypeEnum.UNKNOWN,
});


class _TestAllTypeEnumConverter<String, O> {
  final Map<String, O> map;
  Map<O, String>? reverseMap;

  _TestAllTypeEnumConverter(this.map);

  Map<O, String> get reverse => reverseMap ??= map.map((k, v) => MapEntry(v, k));
}


@immutable
class Point {

  const Point({
    required this.longitude,
    required this.latitude,
  });

  final double longitude;
  final double latitude;

  factory Point.fromJson(Map<String,dynamic> json) => Point(
    longitude: json['longitude'] as double,
    latitude: json['latitude'] as double
  );
  
  Map<String, dynamic> toJson() => {
    'longitude': longitude,
    'latitude': latitude
  };

  Point clone() => Point(
    longitude: longitude,
    latitude: latitude
  );


  Point copyWith({
    double? longitude,
    double? latitude
  }) => Point(
    longitude: longitude ?? this.longitude,
    latitude: latitude ?? this.latitude,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Point && longitude == other.longitude && latitude == other.latitude;

  @override
  int get hashCode => longitude.hashCode ^ latitude.hashCode;
}
