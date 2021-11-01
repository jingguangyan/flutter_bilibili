import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/color.dart';

/// 登录输入框，自定义widget
class LoginInput extends StatefulWidget {
  final String title; // 输入框标题
  final String hint; // 输入框提示
  final ValueChanged<String>? onChanged; // 输入框值改变回调函数
  final ValueChanged<bool>? focusChanged; // 输入框焦点发生变化回调函数
  final bool lineStretch; // 用于控制输入框央视
  final bool obscureTexrt; // 输入框是否为密码
  final TextInputType? keboardType; // 输入框状态

  const LoginInput({
    Key? key,
    required this.title,
    required this.hint,
    this.onChanged,
    this.focusChanged,
    this.lineStretch = false,
    this.obscureTexrt = false,
    this.keboardType,
  }) : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // 是否获取光标的监听
    _focusNode.addListener(() {
      print('Has focus: ${_focusNode.hasFocus}');
      if (widget.focusChanged != null) {
        widget.focusChanged!(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 15),
              width: 100,
              child: Text(
                widget.title,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            _input(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: !widget.lineStretch ? 15 : 0),
          child: const Divider(height: 1, thickness: 0.5),
        )
      ],
    );
  }

  Widget _input() {
    return Expanded(
      child: TextField(
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        obscureText: widget.obscureTexrt,
        keyboardType: widget.keboardType,
        autofocus: !widget.obscureTexrt,
        cursorColor: primary,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 20, right: 20),
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
        ),
      ),
    );
  }
}
