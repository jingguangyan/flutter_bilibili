import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';

import 'video_model.dart';



@immutable
class HomeModel {

  const HomeModel({
    required this.bannerList,
    required this.categoryList,
    required this.videoList,
  });

  final List<BannerMo> bannerList;
  final List<CategoryMo> categoryList;
  final List<VideoModel> videoList;

  factory HomeModel.fromJson(Map<String,dynamic> json) => HomeModel(
    bannerList: (json['bannerList'] as List? ?? []).map((e) => BannerMo.fromJson(e as Map<String, dynamic>)).toList(),
    categoryList: (json['categoryList'] as List? ?? []).map((e) => CategoryMo.fromJson(e as Map<String, dynamic>)).toList(),
    videoList: (json['videoList'] as List? ?? []).map((e) => VideoModel.fromJson(e as Map<String, dynamic>)).toList()
  );
  
  Map<String, dynamic> toJson() => {
    'bannerList': bannerList.map((e) => e.toJson()).toList(),
    'categoryList': categoryList.map((e) => e.toJson()).toList(),
    'videoList': videoList.map((e) => e.toJson()).toList()
  };

  HomeModel clone() => HomeModel(
    bannerList: bannerList.map((e) => e.clone()).toList(),
    categoryList: categoryList.map((e) => e.clone()).toList(),
    videoList: videoList.map((e) => e.clone()).toList()
  );


  HomeModel copyWith({
    List<BannerMo>? bannerList,
    List<CategoryMo>? categoryList,
    List<VideoModel>? videoList
  }) => HomeModel(
    bannerList: bannerList ?? this.bannerList,
    categoryList: categoryList ?? this.categoryList,
    videoList: videoList ?? this.videoList,
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is HomeModel && bannerList == other.bannerList && categoryList == other.categoryList && videoList == other.videoList;

  @override
  int get hashCode => bannerList.hashCode ^ categoryList.hashCode ^ videoList.hashCode;
}

@immutable
class BannerMo {

  const BannerMo({
    this.id,
    this.type,
    this.title,
    this.subtitle,
    this.url,
    this.cover,
    this.createTime,
    this.sticky,
  });

  final String? id;
  final String? type;
  final String? title;
  final String? subtitle;
  final String? url;
  final String? cover;
  final String? createTime;
  final int? sticky;

  factory BannerMo.fromJson(Map<String,dynamic> json) => BannerMo(
    id: json['id'] != null ? json['id'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    title: json['title'] != null ? json['title'] as String : null,
    subtitle: json['subtitle'] != null ? json['subtitle'] as String : null,
    url: json['url'] != null ? json['url'] as String : null,
    cover: json['cover'] != null ? json['cover'] as String : null,
    createTime: json['createTime'] != null ? json['createTime'] as String : null,
    sticky: json['sticky'] != null ? json['sticky'] as int : null
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'type': type,
    'title': title,
    'subtitle': subtitle,
    'url': url,
    'cover': cover,
    'createTime': createTime,
    'sticky': sticky
  };

  BannerMo clone() => BannerMo(
    id: id,
    type: type,
    title: title,
    subtitle: subtitle,
    url: url,
    cover: cover,
    createTime: createTime,
    sticky: sticky
  );


  BannerMo copyWith({
    Optional<String?>? id,
    Optional<String?>? type,
    Optional<String?>? title,
    Optional<String?>? subtitle,
    Optional<String?>? url,
    Optional<String?>? cover,
    Optional<String?>? createTime,
    Optional<int?>? sticky
  }) => BannerMo(
    id: checkOptional(id, this.id),
    type: checkOptional(type, this.type),
    title: checkOptional(title, this.title),
    subtitle: checkOptional(subtitle, this.subtitle),
    url: checkOptional(url, this.url),
    cover: checkOptional(cover, this.cover),
    createTime: checkOptional(createTime, this.createTime),
    sticky: checkOptional(sticky, this.sticky),
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is BannerMo && id == other.id && type == other.type && title == other.title && subtitle == other.subtitle && url == other.url && cover == other.cover && createTime == other.createTime && sticky == other.sticky;

  @override
  int get hashCode => id.hashCode ^ type.hashCode ^ title.hashCode ^ subtitle.hashCode ^ url.hashCode ^ cover.hashCode ^ createTime.hashCode ^ sticky.hashCode;
}

@immutable
class CategoryMo {

  const CategoryMo({
    this.name,
    this.count,
  });

  final String? name;
  final int? count;

  factory CategoryMo.fromJson(Map<String,dynamic> json) => CategoryMo(
    name: json['name'] != null ? json['name'] as String : null,
    count: json['count'] != null ? json['count'] as int : null
  );
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'count': count
  };

  CategoryMo clone() => CategoryMo(
    name: name,
    count: count
  );


  CategoryMo copyWith({
    Optional<String?>? name,
    Optional<int?>? count
  }) => CategoryMo(
    name: checkOptional(name, this.name),
    count: checkOptional(count, this.count),
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is CategoryMo && name == other.name && count == other.count;

  @override
  int get hashCode => name.hashCode ^ count.hashCode;
}
