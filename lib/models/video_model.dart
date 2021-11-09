import 'package:flutter/foundation.dart';
import 'package:quiver/core.dart';
import 'index.dart';



@immutable
class VideoModel {

  const VideoModel({
    this.id,
    this.vid,
    this.title,
    this.tname,
    this.url,
    this.cover,
    this.pubdate,
    this.desc,
    this.view,
    this.duration,
    this.owner,
    this.reply,
    this.favorite,
    this.like,
    this.coin,
    this.share,
    this.createTime,
    this.size,
  });

  final String? id;
  final String? vid;
  final String? title;
  final String? tname;
  final String? url;
  final String? cover;
  final int? pubdate;
  final String? desc;
  final int? view;
  final int? duration;
  final Owner? owner;
  final int? reply;
  final int? favorite;
  final int? like;
  final int? coin;
  final int? share;
  final String? createTime;
  final int? size;

  factory VideoModel.fromJson(Map<String,dynamic> json) => VideoModel(
    id: json['id'] != null ? json['id'] as String : null,
    vid: json['vid'] != null ? json['vid'] as String : null,
    title: json['title'] != null ? json['title'] as String : null,
    tname: json['tname'] != null ? json['tname'] as String : null,
    url: json['url'] != null ? json['url'] as String : null,
    cover: json['cover'] != null ? json['cover'] as String : null,
    pubdate: json['pubdate'] != null ? json['pubdate'] as int : null,
    desc: json['desc'] != null ? json['desc'] as String : null,
    view: json['view'] != null ? json['view'] as int : null,
    duration: json['duration'] != null ? json['duration'] as int : null,
    owner: json['owner'] != null ? Owner.fromJson(json['owner'] as Map<String, dynamic>) : null,
    reply: json['reply'] != null ? json['reply'] as int : null,
    favorite: json['favorite'] != null ? json['favorite'] as int : null,
    like: json['like'] != null ? json['like'] as int : null,
    coin: json['coin'] != null ? json['coin'] as int : null,
    share: json['share'] != null ? json['share'] as int : null,
    createTime: json['createTime'] != null ? json['createTime'] as String : null,
    size: json['size'] != null ? json['size'] as int : null
  );
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'vid': vid,
    'title': title,
    'tname': tname,
    'url': url,
    'cover': cover,
    'pubdate': pubdate,
    'desc': desc,
    'view': view,
    'duration': duration,
    'owner': owner?.toJson(),
    'reply': reply,
    'favorite': favorite,
    'like': like,
    'coin': coin,
    'share': share,
    'createTime': createTime,
    'size': size
  };

  VideoModel clone() => VideoModel(
    id: id,
    vid: vid,
    title: title,
    tname: tname,
    url: url,
    cover: cover,
    pubdate: pubdate,
    desc: desc,
    view: view,
    duration: duration,
    owner: owner?.clone(),
    reply: reply,
    favorite: favorite,
    like: like,
    coin: coin,
    share: share,
    createTime: createTime,
    size: size
  );


  VideoModel copyWith({
    Optional<String?>? id,
    Optional<String?>? vid,
    Optional<String?>? title,
    Optional<String?>? tname,
    Optional<String?>? url,
    Optional<String?>? cover,
    Optional<int?>? pubdate,
    Optional<String?>? desc,
    Optional<int?>? view,
    Optional<int?>? duration,
    Optional<Owner?>? owner,
    Optional<int?>? reply,
    Optional<int?>? favorite,
    Optional<int?>? like,
    Optional<int?>? coin,
    Optional<int?>? share,
    Optional<String?>? createTime,
    Optional<int?>? size
  }) => VideoModel(
    id: checkOptional(id, this.id),
    vid: checkOptional(vid, this.vid),
    title: checkOptional(title, this.title),
    tname: checkOptional(tname, this.tname),
    url: checkOptional(url, this.url),
    cover: checkOptional(cover, this.cover),
    pubdate: checkOptional(pubdate, this.pubdate),
    desc: checkOptional(desc, this.desc),
    view: checkOptional(view, this.view),
    duration: checkOptional(duration, this.duration),
    owner: checkOptional(owner, this.owner),
    reply: checkOptional(reply, this.reply),
    favorite: checkOptional(favorite, this.favorite),
    like: checkOptional(like, this.like),
    coin: checkOptional(coin, this.coin),
    share: checkOptional(share, this.share),
    createTime: checkOptional(createTime, this.createTime),
    size: checkOptional(size, this.size),
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is VideoModel && id == other.id && vid == other.vid && title == other.title && tname == other.tname && url == other.url && cover == other.cover && pubdate == other.pubdate && desc == other.desc && view == other.view && duration == other.duration && owner == other.owner && reply == other.reply && favorite == other.favorite && like == other.like && coin == other.coin && share == other.share && createTime == other.createTime && size == other.size;

  @override
  int get hashCode => id.hashCode ^ vid.hashCode ^ title.hashCode ^ tname.hashCode ^ url.hashCode ^ cover.hashCode ^ pubdate.hashCode ^ desc.hashCode ^ view.hashCode ^ duration.hashCode ^ owner.hashCode ^ reply.hashCode ^ favorite.hashCode ^ like.hashCode ^ coin.hashCode ^ share.hashCode ^ createTime.hashCode ^ size.hashCode;
}

@immutable
class Owner {

  const Owner({
    this.name,
    this.face,
    this.fans,
  });

  final String? name;
  final String? face;
  final int? fans;

  factory Owner.fromJson(Map<String,dynamic> json) => Owner(
    name: json['name'] != null ? json['name'] as String : null,
    face: json['face'] != null ? json['face'] as String : null,
    fans: json['fans'] != null ? json['fans'] as int : null
  );
  
  Map<String, dynamic> toJson() => {
    'name': name,
    'face': face,
    'fans': fans
  };

  Owner clone() => Owner(
    name: name,
    face: face,
    fans: fans
  );


  Owner copyWith({
    Optional<String?>? name,
    Optional<String?>? face,
    Optional<int?>? fans
  }) => Owner(
    name: checkOptional(name, this.name),
    face: checkOptional(face, this.face),
    fans: checkOptional(fans, this.fans),
  );

  @override
  bool operator ==(Object other) => identical(this, other)
    || other is Owner && name == other.name && face == other.face && fans == other.fans;

  @override
  int get hashCode => name.hashCode ^ face.hashCode ^ fans.hashCode;
}
