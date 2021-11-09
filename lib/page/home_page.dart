import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/hi_state.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/home_dao.dart';
import 'package:flutter_bilibili/models/index.dart';
import 'package:flutter_bilibili/models/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigtor.dart';
import 'package:flutter_bilibili/page/home_tab_page.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late RouteChangeListener listener;
  late TabController _tabController;
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categoryList.length, vsync: this);
    listener = (current, pre) {
      print('home:current: ${current.page}');
      print('home:pre:${pre?.page}');

      if (widget == current.page || current.page is HomePage) {
        print('打开了首页 onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页：onPause');
      }
    };
    HiNavigator.getInstance().addListener(listener);
    loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 30),
            child: _tabBar(),
          ),
          Flexible(
            child: TabBarView(
              controller: _tabController,
              children: categoryList.map<HomeTabPage>((tab) {
                return HomeTabPage(
                  categoryName: tab.name ?? '',
                  bannerList: tab.name == '推荐' ? bannerList : null,
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _tabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      labelColor: Colors.black,
      indicator: const UnderlineTabIndicator(
        borderSide: BorderSide(color: primary, width: 3),
        insets: EdgeInsets.symmetric(horizontal: 15),
      ),
      tabs: categoryList
          .map<Tab>(
            (tab) => Tab(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Text(
                  tab.name ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  void loadData() async {
    try {
      HomeModel result = await HomeDao.get("推荐");
      if (result.categoryList.isNotEmpty) {
        _tabController = TabController(length: result.categoryList.length, vsync: this);
      }

      setState(() {
        categoryList = result.categoryList;
        bannerList = result.bannerList;
        _isLoading = false;
      });
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    } on HiNetError catch (e) {
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    }
  }
}
