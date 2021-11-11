import 'package:flutter/material.dart';
import 'package:flutter_bilibili/navigator/hi_navigtor.dart';
import 'package:flutter_bilibili/page/favorite_page.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/profile_page.dart';
import 'package:flutter_bilibili/page/ranking_page.dart';
import 'package:flutter_bilibili/util/color.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key? key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;

  late List<Widget> _pages;
  bool _hasBuild = false;

  BottomNavigationBarItem _bottomItem({required String label, required IconData icon}) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
    );
  }

  static int initialPage = 0;
  int _currentIndex = 0;
  final PageController _pageController = PageController(initialPage: initialPage);

  @override
  Widget build(BuildContext context) {
    _pages = [
      HomePage(
        onJumpTo: (int index) => _onJumpTo(index),
      ),
      RankingPage(),
      FavoritePage(),
      ProfilePage()
    ];
    if (!_hasBuild) {
      HiNavigator.getInstance().onBottomTabChange(initialPage, _pages[initialPage]);
      _hasBuild = true;
    }

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle: TextStyle(color: _defaultColor),
        selectedLabelStyle: TextStyle(color: _activeColor),
        selectedItemColor: _activeColor,
        showSelectedLabels: true,
        currentIndex: _currentIndex,
        onTap: (int index) {
          _onJumpTo(index);
        },
        items: <BottomNavigationBarItem>[
          _bottomItem(label: '首页', icon: Icons.home),
          _bottomItem(label: '排行', icon: Icons.local_fire_department),
          _bottomItem(label: '收藏', icon: Icons.favorite),
          _bottomItem(label: '我的', icon: Icons.tv),
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (int index) {
          _onJumpTo(index, pageChange: true);
        },
        children: _pages,
      ),
    );
  }

  void _onJumpTo(int index, {pageChange = false}) {
    if (!pageChange) {
      _pageController.jumpToPage(index);
    } else {
      HiNavigator.getInstance().onBottomTabChange(index, _pages[index]);
    }
    setState(() {
      _currentIndex = index;
    });
  }
}
