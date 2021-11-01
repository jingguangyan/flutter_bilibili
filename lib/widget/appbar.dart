import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// 自定义顶部 appbar
AppBar appBar(
    {required String title,
    required String rightTitle,
    required VoidCallback rightButtonClick}) {
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
