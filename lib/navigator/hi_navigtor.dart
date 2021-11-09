import 'package:flutter/material.dart';
import 'package:flutter_bilibili/navigator/bottom_navigator.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';

typedef RouteChangeListener = Function(RouteStatusInfo current, RouteStatusInfo? pre);

/// 创建页面
MaterialPage pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

/// 获取routeStatus 在页面栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0, len = pages.length; i < len; i++) {
    if (getStatus(pages[i]) == routeStatus) return i;
  }
  return -1;
}

/// 自定义路由封装，路由状态

enum RouteStatus { login, registration, home, detail, unknown }

/// 获取page对应的 RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is LoginPage) return RouteStatus.login;
  if (page.child is RegistrationPage) return RouteStatus.registration;
  if (page.child is BottomNavigator) return RouteStatus.home;
  if (page.child is VideoDetailPage) return RouteStatus.detail;
  return RouteStatus.unknown;
}

/// 路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

///监听路由页面跳转
///感知当前页面是否压在后台
class HiNavigator extends _RouteJumpListener {
  RouteJumpListener? _routeJump;
  final List<RouteChangeListener> _listeners = [];
  RouteStatusInfo? _current;
  // 首页底部tab
  RouteStatusInfo? _bottomTab;

  static HiNavigator? _instance;
  HiNavigator._();
  static HiNavigator getInstance() {
    return _instance ??= HiNavigator._();
  }

  /// 注册路由的跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    _routeJump = routeJumpListener;
  }

  @override
  void onJumpTo(RouteStatus routeStataus, {Map? args}) {
    print(routeStataus);
    print(_routeJump);
    if (_routeJump != null) {
      _routeJump!.onJumpTo!(routeStataus, args: args);
    }
  }

  /// 首页底部bottom切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab!);
  }

  /// 添加路由监听
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  /// 移除路由监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  /// 通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current = RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      // 如果打开的是首页，则明确到首页具体的tab
      current = _bottomTab!;
    }
    print('hi_navigator:current:${current.page}');
    print('hi_navigator:pre:${_current?.page}');

    _listeners.forEach((listener) {
      listener(current, _current);
    });
    _current = current;
  }
}

/// 抽象类供 HiNavigator 实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStataus, {Map? args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map? args});

/// 定义路由跳转逻辑实现的功能
class RouteJumpListener {
  final OnJumpTo? onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
