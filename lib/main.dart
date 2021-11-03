import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';

import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigtor.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/util/color.dart';

void main() {
  runApp(const BiliApp());
}

class BiliApp extends StatefulWidget {
  const BiliApp({Key? key}) : super(key: key);

  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  final BiliRouteDelegate _routeDelegate = BiliRouteDelegate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HiCache>(
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<HiCache> asyncSnapshot) {
        Widget widget = asyncSnapshot.connectionState == ConnectionState.done
            ? Router(routerDelegate: _routeDelegate)
            : const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: white,
          ),
          home: widget,
        );
      },
    );
  }
}

class BiliRouteDelegate extends RouterDelegate<BiliRoutePath> with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  RouteStatus _routeStatus = RouteStatus.home;
  List<MaterialPage> pages = [];
  VideoModel? videoModel;

  @override
  Widget build(BuildContext context) {
    // 管理路由堆栈
    List<MaterialPage> _tempPages = pages;
    int index = getPageIndex(pages, routeStatus);
    if (index != -1) {
      // 要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      // tips 具体规则可以根据需要进行调整，这里要求栈中心只允许有一个同样的页面实例
      _tempPages = _tempPages.sublist(0, index);
    }
    late MaterialPage page;
    if (routeStatus == RouteStatus.home) {
      // 跳转首页时将栈中其他页面进行出栈，因为首页不可回退；
      pages.clear();
      page = pageWrap(HomePage(
        onJumpToDetail: (VideoModel videM) {
          videoModel = videM;
          notifyListeners();
        },
      ));
    } else if (routeStatus == RouteStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel: videoModel!));
    } else if (routeStatus == RouteStatus.registration) {
      page = pageWrap(RegistrationPage(
        onJumpToLogin: () {
          _routeStatus = RouteStatus.login;
          notifyListeners();
        },
      ));
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(LoginPage());
    }
    // 重新创建一个数组，否则pages因引用没有改变，路由不会生效
    _tempPages = [..._tempPages, page];
    pages = _tempPages;
    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (Route route, dynamic result) {
        // 在这里可以控制是否可以返回
        if (!route.didPop(result)) return false;
        return true;
      },
    );
  }

  RouteStatus get routeStatus {
    if (_routeStatus != RouteStatus.registration && !hasLogin) {
      return _routeStatus = RouteStatus.login;
    } else if (videoModel != null) {
      return _routeStatus = RouteStatus.detail;
    }
    return _routeStatus;
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<bool> popRoute() {
    throw UnimplementedError();
  }

  @override
  Future<void> setNewRoutePath(BiliRoutePath configuration) async {}
}

//定义路由数据，path
class BiliRoutePath {
  final String location;

  BiliRoutePath.home() : location = "/";
  BiliRoutePath.detail() : location = "/detail";
}

/// 创建页面
pageWrap(Widget child) {
  return MaterialPage(
    key: ValueKey(child.hashCode),
    child: child,
  );
}
