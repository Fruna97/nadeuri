import 'dart:developer';

import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _validationMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ListView(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              children: <Widget>[
                TextField(
                  controller: _emailController, 
                  decoration: const InputDecoration(
                    labelText: "이메일",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: "비밀번호",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        log("비밀번호 재설정 button pressed");
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.all(0),
                        minimumSize: Size.zero,
                      ),
                      child: const Text("비밀번호 재설정"),
                    ),
                  ],
                ),
                if (_validationMessage.isNotEmpty) const SizedBox(height: 12.0),
                if (_validationMessage.isNotEmpty) Center(child: Text(_validationMessage, style: TextStyle(color: Colors.red, fontSize: 12))),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () {
                    log("로그인 button pressed");
                    final String email = _emailController.text;
                    final String password = _passwordController.text;
                            
                    if (email.isEmpty) {
                      setState(() {
                        _validationMessage = "이메일을 입력해 주세요.";
                      });
                    } else if (password.isEmpty) {
                      setState(() {
                        _validationMessage = "비밀번호를 입력해 주세요.";
                      });
                    } else {
                            
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: const Text("로그인"),
                ),
                const SizedBox(height: 18.0),
                const Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Divider(endIndent: 12.0)),
                    Text("또는"),
                    Expanded(child: Divider(indent: 12.0)),
                  ],
                ),
                const SizedBox(height: 18.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      log("카카오로 로그인 button pressed");
                    },
                    style: ElevatedButton.styleFrom(shape: const CircleBorder()),
                    child: const Text("K"), // TODO: 카카오 OAuth 로고로 교체
                  ),
                ),
                const SizedBox(height: 18.0),
                const Divider(),
                const SizedBox(height: 18.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("아직 회원이 아니신가요?"),
                    const SizedBox(width: 12.0),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/sign-up");
                        log("회원가입 button pressed");
                      },
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.all(0.0),
                        minimumSize: Size.zero,
                      ),
                      child: const Text("회원가입 하기"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
