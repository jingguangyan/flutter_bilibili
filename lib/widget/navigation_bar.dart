import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

class NavigationBar extends StatelessWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget child;

  const NavigationBar({
    Key? key,
    this.statusStyle = StatusStyle.DARK_CONTENT,
    this.color = Colors.white,
    this.height = 46,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 状态栏高度
    _statusBarInit();
    double top = MediaQuery.of(context).padding.top;
    print('top: $top');
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height + top,
      child: child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: color),
    );
  }

  void _statusBarInit() {
    // 设置沉浸式状态栏
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: color,
        statusBarIconBrightness: statusStyle == StatusStyle.DARK_CONTENT ? Brightness.dark : Brightness.light,
        statusBarBrightness: statusStyle == StatusStyle.DARK_CONTENT ? Brightness.light : Brightness.dark,
      ),
    );
  }
}
