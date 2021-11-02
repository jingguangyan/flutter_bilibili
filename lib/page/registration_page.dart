import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/util/string_util.dart';
import 'package:flutter_bilibili/util/toast.dart';
import 'package:flutter_bilibili/widget/appbar.dart';
import 'package:flutter_bilibili/widget/login_button.dart';
import 'package:flutter_bilibili/widget/login_effect.dart';
import 'package:flutter_bilibili/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback? onJumpToLogin;
  const RegistrationPage({Key? key, this.onJumpToLogin}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isProtect = false;
  bool loginEnable = false;

  late String userName;
  late String password;
  late String rePassword;
  late String imoocId;
  late String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: '注册',
        rightTitle: "登录",
        rightButtonClick: widget.onJumpToLogin,
      ),
      body: Container(
        child: ListView(
          // 自适应键盘弹起，防止遮挡
          children: [
            LoginEffect(protect: _isProtect),
            LoginInput(
              title: "用户名",
              hint: "请输入用户名",
              onChanged: (String text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              title: "密码",
              hint: "请输入密码",
              obscureTexrt: true,
              focusChanged: (bool focus) {
                setState(() {
                  _isProtect = focus;
                });
              },
              onChanged: (String text) {
                password = text;
                checkInput();
              },
            ),
            LoginInput(
              title: "确认密码",
              hint: "请再次输入密码",
              obscureTexrt: true,
              focusChanged: (bool focus) {
                setState(() {
                  _isProtect = focus;
                });
              },
              onChanged: (String text) {
                rePassword = text;
                checkInput();
              },
            ),
            LoginInput(
              title: "慕课网",
              hint: "请输入你的慕课网用户ID",
              keyboardType: TextInputType.number,
              onChanged: (String text) {
                imoocId = text;
                checkInput();
              },
            ),
            LoginInput(
              title: "课程订单号",
              hint: "请输入课程订单号后四位",
              keyboardType: TextInputType.number,
              lineStretch: true,
              onChanged: (String text) {
                orderId = text;
                checkInput();
              },
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: LoginButton(
                title: '注册',
                enable: loginEnable,
                onPressed: checkParams,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(rePassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  Widget _loginButton() {
    return InkWell(
      onTap: () {
        if (loginEnable) {
          checkParams();
          // send();
        } else {
          print('loginEnable is false');
        }
      },
      child: Text('注册'),
    );
  }

  void send() async {
    try {
//      var result = await LoginDao.registration("misszeng", "zeng123456", "7587899", "7807");
      var result =
          await LoginDao.registration(userName, password, imoocId, orderId);

      if (result["code"] == 0) {
        showToast("注册成功");
        // HiNavigator.getInstance().onJumpTo((RouteStatus.login));
      } else {
        showWarnToast(result["msg"]);
      }
    } on NeedAuth catch (e) {
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      showWarnToast(e.message);
    }
  }

  void checkParams() {
    String? tips;
    if (password != rePassword) {
      tips = "两次密码不一致";
    } else if (orderId.length != 4) {
      tips = "请输入订单号后四位";
    }
    if (tips != null) {
      showWarnToast(tips);
      return;
    }
    send();
  }
}
