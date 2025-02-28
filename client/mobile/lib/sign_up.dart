import 'dart:developer';

import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
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
              const SizedBox(height: 24.0),
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
              const SizedBox(height: 6.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "비밀번호 확인",
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 24.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "별명",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 36.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ElevatedButton(
                  onPressed: () {
                    log("회원가입 button pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: const Text("회원가입"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
