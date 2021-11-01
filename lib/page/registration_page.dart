import 'package:flutter/material.dart';
import 'package:flutter_bilibili/widget/appbar.dart';
import 'package:flutter_bilibili/widget/login_effect.dart';
import 'package:flutter_bilibili/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _isProtect = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: '注册',
        rightTitle: "登录",
        rightButtonClick: () {
          print('rigjt button click');
        },
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
                print(text);
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
                print(text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
