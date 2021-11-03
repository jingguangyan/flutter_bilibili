import 'package:flutter/material.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';

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
  if (page.child is HomePage) return RouteStatus.home;
  if (page.child is VideoDetailPage) return RouteStatus.detail;
  return RouteStatus.unknown;
}

/// 路由信息
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}
