import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/models/video_model.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/appbar.dart';
import 'package:flutter_bilibili/widget/hi_tab.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:flutter_bilibili/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;
  const VideoDetailPage({Key? key, required this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> with TickerProviderStateMixin {
  late TabController _tabController;
  List _tabs = ["简介", "评论288"];
  @override
  void initState() {
    super.initState();
    // 黑色状态栏，仅安卓
    changeStatusBar(color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: Column(children: <Widget>[
          NavigationBar(
            color: Colors.black,
            statusStyle: StatusStyle.LIGHT_CONTENT,
            height: Platform.isAndroid ? 0 : 46,
          ),
          _buildVideoView(),
          _buildTabNabigation()
        ]),
      ),
    );
  }

  Widget _buildVideoView() {
    VideoModel model = widget.videoModel;
    return VideoView(
      url: model.url ?? '',
      cover: model.cover,
      overlayUI: videoAppBar(),
    );
  }

  Widget _buildTabNabigation() {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        height: 39,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _tabBar(),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.live_tv_rounded, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  Widget _tabBar() {
    List<Widget> tabs = _tabs.map<Tab>((tab) {
      return Tab(
        child: Text(
          tab,
          style: const TextStyle(fontSize: 16),
        ),
      );
    }).toList();

    return HiTab(
      tabs: tabs,
      controller: _tabController,
      fontSize: 16,
      unselectedLabelColor: Colors.black54,
      insets: 13,
    );
  }
}
