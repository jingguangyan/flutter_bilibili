import 'package:flutter/material.dart';
import 'package:flutter_bilibili/models/video_model.dart';
import 'package:flutter_bilibili/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;
  const VideoDetailPage({Key? key, required this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: <Widget>[
        Text('视频详情页， vid:${widget.videoModel.vid}'),
        Text('视频详情页， title:${widget.videoModel.title}'),
        _videoView(),
      ]),
    );
  }

  Widget _videoView() {
    VideoModel model = widget.videoModel;
    return VideoView(url: model.url ?? '', cover: model.cover);
  }
}
