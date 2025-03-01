import 'dart:developer';

import 'package:flutter/material.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "이메일",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 8.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
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
              ),
              const SizedBox(height: 12.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ElevatedButton(
                  onPressed: () {
                    log("로그인 button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: const Text("로그인"),
                ),
              ),
              const SizedBox(height: 18.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(child: Divider(endIndent: 12.0)),
                    Text("또는"),
                    Expanded(child: Divider(indent: 12.0)),
                  ],
                ),
              ),
              const SizedBox(height: 18.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      log("카카오로 로그인 button pressed");
                    },
                    style: ElevatedButton.styleFrom(shape: CircleBorder()),
                    child: Text("K"), // TODO: 카카오 OAuth 로고로 교체
                  ),
                ],
              ),
              const SizedBox(height: 18.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: Divider(),
              ),
              const SizedBox(height: 18.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("아직 회원이 아니신가요?"),
                    const SizedBox(width: 12.0),
                    TextButton(
                      onPressed: () {
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
