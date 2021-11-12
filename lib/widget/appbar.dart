import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/view_util.dart';

/// 自定义顶部 appbar
AppBar appBar({required String title, required String rightTitle, VoidCallback? rightButtonClick}) {
  return AppBar(
    // 让 title 居左
    centerTitle: false,
    titleSpacing: 0,
    leading: BackButton(),
    title: Text(title, style: TextStyle(fontSize: 18)),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[500],
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    ],
  );
}

/// 视频详情页appbar
videoAppBar() {
  return Container(
    padding: const EdgeInsets.only(right: 8),
    decoration: BoxDecoration(gradient: blackLinearGradient(fromTop: true)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const BackButton(color: Colors.white),
        Row(
          children: const <Widget>[
            Icon(Icons.live_tv_rounded, color: Colors.white, size: 20),
            Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(Icons.more_vert_rounded, color: Colors.white, size: 20),
            ),
          ],
        )
      ],
    ),
  );
}
