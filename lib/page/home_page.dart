import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/hi_state.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/home_dao.dart';
import 'package:flutter_bilibili/models/index.dart';
import 'package:flutter_bilibili/models/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigtor.dart';
import 'package:flutter_bilibili/page/home_tab_page.dart';
import 'package:flutter_bilibili/page/profile_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/util/color.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/hi_tab.dart';
import 'package:flutter_bilibili/widget/loading_container.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;
  const HomePage({Key? key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin, WidgetsBindingObserver {
  late RouteChangeListener listener;
  late TabController _tabController;
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];
  bool _isLoading = true;
  Widget? _currentPage;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _tabController = TabController(length: categoryList.length, vsync: this);
    listener = (current, pre) {
      print('home:current: ${current.page}');
      print('home:pre:${pre?.page}');

      _currentPage = current.page;

      if (widget == current.page || current.page is HomePage) {
        print('打开了首页 onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页：onPause');
      }
      // 当页面返回到首页恢复首页的状态栏样式
      if (pre?.page is VideoDetailPage && !(current.page is ProfilePage)) {
        changeStatusBar(color: Colors.white, statusStyle: StatusStyle.DARK_CONTENT);
      }
    };
    HiNavigator.getInstance().addListener(listener);
    loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    _tabController.dispose();
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(state);
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设它们可能在任何时候暂停；
        break;
      case AppLifecycleState.resumed: // 从后台切换前台，界面可见
        // fix Android 压后台，状态栏字体颜色变白问题
        if (!(_currentPage is VideoDetailPage)) {
          changeStatusBar(color: Colors.white, statusStyle: StatusStyle.DARK_CONTENT);
        }
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        break;
      case AppLifecycleState.detached: // APP结束时调用
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
        cover: true,
        isLoading: _isLoading,
        child: Column(
          children: <Widget>[
            NavigationBar(
              height: 50,
              child: _appBar(),
              color: Colors.white,
              statusStyle: StatusStyle.DARK_CONTENT,
            ),
            Container(
              color: Colors.white,
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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  Widget _tabBar() {
    List<Widget> tabs = categoryList.map<Tab>((tab) {
      return Tab(
        child: Text(
          tab.name ?? '',
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

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: const Image(
                height: 46,
                width: 46,
                image: AssetImage('images/avatar.png'),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 32,
                  alignment: Alignment.centerLeft,
                  child: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  decoration: BoxDecoration(color: Colors.grey[100]),
                ),
              ),
            ),
          ),
          Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          InkWell(
            onTap: () {
              // HiNavigator.getInstance().onJumpTo(RouteStatus.notice);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(
                Icons.mail_outline,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
