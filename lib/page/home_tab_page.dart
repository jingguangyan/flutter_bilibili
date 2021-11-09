import 'package:flutter/material.dart';
import 'package:flutter_bilibili/models/home_model.dart';
import 'package:flutter_bilibili/widget/hi_banner.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<BannerMo>? bannerList;
  const HomeTabPage({Key? key, required this.categoryName, this.bannerList}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.only(top: 15),
        children: <Widget>[if (widget.bannerList != null) _banner()],
      ),
    );
  }

  Widget _banner() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: HiBanner(
        bannerList: widget.bannerList!,
      ),
    );
  }
}
