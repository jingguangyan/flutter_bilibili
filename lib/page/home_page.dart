import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigtor.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin {
  late RouteChangeListener listener;
  @override
  void initState() {
    super.initState();
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
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            Text('首页'),
            MaterialButton(
              onPressed: () {
                HiNavigator.getInstance().onJumpTo(
                  RouteStatus.detail,
                  args: {"videoModel": VideoModel(1001)},
                );
              },
              child: Text('详情'),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
