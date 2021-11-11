import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/home_dao.dart';
import 'package:flutter_bilibili/models/home_model.dart';
import 'package:flutter_bilibili/models/index.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widget/hi_banner.dart';
import 'package:flutter_bilibili/widget/video_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<BannerMo>? bannerList;
  const HomeTabPage({Key? key, required this.categoryName, this.bannerList}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  List<VideoModel> videoList = [];
  int _pageIndex = 1;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        crossAxisCount: 2,
        itemCount: videoList.length,
        itemBuilder: (BuildContext context, int index) {
          // 有banner时第一个item位置显示banner
          if (widget.bannerList != null && index == 0) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: _banner(),
            );
          }
          return VideoCard(videoModel: videoList[index]);
        },
        staggeredTileBuilder: (int index) {
          if (widget.bannerList != null && index == 0) {
            return StaggeredTile.fit(2);
          }
          return StaggeredTile.fit(1);
        },
      ),
      // ListView(
      //   padding: EdgeInsets.only(top: 15),
      //   children: <Widget>[if (widget.bannerList != null) _banner()],
      // ),
    );
  }

  Widget _banner() {
    return HiBanner(
      bannerList: widget.bannerList!,
    );
  }

  void _loadData({bool loadMore = false}) async {
    if (!loadMore) {
      _pageIndex = 1;
    }
    int currentIndex = _pageIndex + (loadMore ? 1 : 0);

    try {
      HomeModel result = await HomeDao.get(widget.categoryName, pageIndex: currentIndex, pageSize: 50);
      setState(() {
        if (loadMore) {
          if (result.videoList.isNotEmpty) {
            // 合成一个新数组
            videoList = [...videoList, ...result.videoList];
            _pageIndex++;
          }
        } else {
          videoList = result.videoList;
        }
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
      setState(() {});
    } on HiNetError catch (e) {
      showWarnToast(e.message);
      setState(() {});
    }
  }
}
