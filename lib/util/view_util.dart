import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';

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

///黑色线性渐变
blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
      colors: const [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent,
      ]);
}

/// 修改状态栏
void changeStatusBar({color: Colors.white, StatusStyle statusStyle: StatusStyle.DARK_CONTENT}) {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: color,
      statusBarIconBrightness: statusStyle == StatusStyle.DARK_CONTENT ? Brightness.dark : Brightness.light,
      statusBarBrightness: statusStyle == StatusStyle.DARK_CONTENT ? Brightness.light : Brightness.dark,
    ),
  );
}
