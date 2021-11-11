import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_bilibili/widget/hi_video_controls.dart';

class VideoView extends StatefulWidget {
  final String url;
  final String? cover;
  final bool autoPlay;
  final bool looping;
  final double aspectRatio;
  const VideoView({
    Key? key,
    required this.url,
    this.cover,
    this.autoPlay = false,
    this.looping = false,
    this.aspectRatio = 16 / 9,
  }) : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _videoPlayerController; //video_player //video_player 播放器 Controller
  late ChewieController _chewieController; // chewie 播放器 Controller
  //封面
  get _placeholder => FractionallySizedBox(widthFactor: 1, child: cachedImage(widget.cover ?? ''));

  // 进度条颜色
  get _progressColors => ChewieProgressColors(
        playedColor: primary,
        handleColor: primary,
        backgroundColor: Colors.grey,
        bufferedColor: primary[50]!,
      );

  @override
  void initState() {
    super.initState();
    _videoPlayerController = VideoPlayerController.network(widget.url);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      placeholder: _placeholder,
      showOptions: false,
      allowMuting: false,
      allowPlaybackSpeedChanging: false,
      customControls: HiMaterialControls(
        showLoadingOnInitialize: false,
        showBigPlayIcon: false,
        bottomGradient: blackLinearGradient(),
      ),
      materialProgressColors: _progressColors,
    );
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth / widget.aspectRatio;

    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
