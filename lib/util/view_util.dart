import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

///带缓存的image

Widget cachedImage(String url, {double? width, double? height}) {
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    height: height,
    placeholder: (BuildContext context, String url) {
      return Container(color: Colors.grey[200]);
    },
    errorWidget: (BuildContext context, String url, dynamic error) {
      return const Icon(Icons.error);
    },
  );
}
