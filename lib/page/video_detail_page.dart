import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/models/video_model.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/appbar.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:flutter_bilibili/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;
  const VideoDetailPage({Key? key, required this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  void initState() {
    super.initState();
    // 黑色状态栏，仅安卓
    changeStatusBar(color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
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
          _videoView(),
          Text('视频详情页， vid:${widget.videoModel.vid}'),
          Text('视频详情页， title:${widget.videoModel.title}'),
        ]),
      ),
    );
  }

  Widget _videoView() {
    VideoModel model = widget.videoModel;
    return VideoView(
      url: model.url ?? '',
      cover: model.cover,
      overlayUI: videoAppBar(),
    );
  }
}
