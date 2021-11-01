import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/http/request/notice_request.dart';
import 'package:flutter_bilibili/http/request/test_request.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/util/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: white,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: RegistrationPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() async {
    await testLogin();
    testNotice();
  }

  @override
  void initState() {
    super.initState();
    HiCache.preInit();
  }

  void test() {
    const jsonString =
        "{\"name\": \"flutter\", \"url\": \"https://coding.imooc.com/class/487.html\" }";
    // json 转 map
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    print("name:${jsonMap['name']}");
    print("url:${jsonMap['url']}");
    // map 转 json
    String json = jsonEncode(jsonMap);
    print('json:${json}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void testNotice() async {
    var notice = await HiNet.getInstance().fire(NoticeRequest());
    print(notice);
  }

  Future<dynamic> testLogin() async {
    var result = LoginDao.login("misszeng", "zeng123456");
    return result;
  }
}
