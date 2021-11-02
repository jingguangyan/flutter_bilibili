import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
// import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widget/appbar.dart';
import 'package:flutter_bilibili/widget/login_button.dart';
import 'package:flutter_bilibili/widget/login_effect.dart';
import 'package:flutter_bilibili/widget/login_input.dart';
import 'package:flutter_bilibili/util/string_util.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool protect = false;
  bool loginEnable = false;
  late String userName = '';
  late String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "密码登录",
        rightTitle: '注册',
        rightButtonClick: () {
          // HiNavigator.getInstance().onJumpTo((RouteStatus.registration));
        },
      ),
      body: Container(
        child: ListView(
          children: [
            LoginEffect(
              protect: protect,
            ),
            LoginInput(
              title: '用户名',
              hint: '请输入用户名',
              onChanged: (e) {
                userName = e;
                checkInput();
              },
            ),
            LoginInput(
              title: "密码",
              hint: "请输入密码",
              obscureTexrt: true,
              lineStretch: true,
              onChanged: (e) {
                password = e;
                checkInput();
              },
              focusChanged: (focus) {
                setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: LoginButton(
                title: "登录",
                enable: loginEnable,
                onPressed: send,
              ),
            )
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
      enable = true;
    } else {
      enable = false;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      var result = await LoginDao.login(userName, password);
      print(result);

      if (result["code"] == 0) {
        showToast("登录成功");
        // HiNavigator.getInstance().onJumpTo((RouteStatus.home));
      } else {
        showWarnToast(result["msg"]);
      }
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      showWarnToast(e.message);
    } catch (e) {
      showWarnToast(e.toString());
    }
  }
}
