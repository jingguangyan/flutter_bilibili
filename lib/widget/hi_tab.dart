import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/color.dart';

class HiTab extends StatelessWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final double? fontSize;
  final double borderWidth;
  final double insets;
  final Color? unselectedLabelColor;

  const HiTab({
    Key? key,
    required this.tabs,
    this.controller,
    this.fontSize = 13,
    this.borderWidth = 2,
    this.insets = 15,
    this.unselectedLabelColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      isScrollable: true,
      labelColor: primary,
      unselectedLabelColor: unselectedLabelColor,
      labelStyle: TextStyle(fontSize: fontSize),
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: primary, width: borderWidth),
        insets: EdgeInsets.symmetric(horizontal: insets),
      ),
      tabs: tabs,
    );
  }
}
