import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Center(child: SignUpForm())));
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _emailKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordKey = GlobalKey<FormFieldState>();
  final GlobalKey<FormFieldState> _passwordCheckKey = GlobalKey<FormFieldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordCheckFocusNode = FocusNode();
  Widget? _passwordError;

  void _togglePasswordErrorState() {
    setState(() {
      if (_passwordError == null) {
        _passwordError = SizedBox.shrink();
      } else {
        _passwordError = null;
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        _emailKey.currentState?.validate();
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        _passwordCheckKey.currentState?.validate();
      }
    });
    _passwordCheckFocusNode.addListener(() {
      if (!_passwordCheckFocusNode.hasFocus) {
        _passwordCheckKey.currentState?.validate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text("회원가입", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))]),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              key: _emailKey,
              controller: _emailController,
              focusNode: _emailFocusNode,
              decoration: const InputDecoration(labelText: "이메일", helperText: "추후 이메일을 통해 비밀번호를 재설정 하실 수 있습니다.", border: OutlineInputBorder()),
              validator: (String? email) {
                final regExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]+$");
                if (email == null || email.isEmpty) {
                  return "이메일을 입력해 주세요.";
                } else if (!regExp.hasMatch(email)) {
                  // 정규 표현식을 사용하여 이메일 형식 검증
                  return "올바른 형식의 이메일을 입력해 주세요.";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              key: _passwordKey,
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              decoration: InputDecoration(
                labelText: "비밀번호",
                border: const OutlineInputBorder(),
                error: _passwordError, // "비밀번호 확인" 필드에서 error 상태를 조절하기 위한 state
              ),
              obscureText: true,
            ),
          ),
          const SizedBox(height: 6.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              key: _passwordCheckKey,
              controller: _passwordCheckController,
              focusNode: _passwordCheckFocusNode,
              decoration: const InputDecoration(labelText: "비밀번호 확인", border: OutlineInputBorder()),
              obscureText: true,
              validator: (String? passwordCheck) {
                String password = _passwordController.text;

                // "비밀번호" 필드와 "비밀번호 확인" 필드의 검증 메시지 모두 "비밀번호 확인" 필드 아래에 표시
                if (password.isEmpty) {
                  if (_passwordError == null) _togglePasswordErrorState();
                  return "비밀번호를 입력해 주세요.";
                } else if (_passwordError != null) {
                  _togglePasswordErrorState();
                }

                if (passwordCheck == null || passwordCheck.isEmpty) {
                  return "비밀번호 확인란을 입력해 주세요.";
                } else if (password != passwordCheck) {
                  return "비밀번호가 동일하지 않습니다.";
                }
                return null;
              },
            ),
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: "별명", helperText: "별명을 입력하지 않으시면, 이메일을 기반으로 자동으로 생성됩니다.", border: OutlineInputBorder()),
            ),
          ),
          const SizedBox(height: 32.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  log("모든 필드 검증 완료");

                  showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));

                  final response = await http
                      .post(
                        // Uri.parse("http://localhost:8080/member/signup"), // Chrome
                        Uri.parse("http://10.0.2.2:8080/member/signup"), // Android
                        headers: {"content-type": "application/json; charset=UTF-8"},
                        body: jsonEncode({"email": _emailController.text, "password": _passwordController.text}),
                      )
                      .timeout(
                        const Duration(seconds: 5),
                        onTimeout: () {
                          return http.Response(
                            jsonEncode({"message": "타임아웃", "data": null}),
                            HttpStatus.requestTimeout,
                            headers: {"content-type": "application/json; charset=UTF-8"},
                          );
                        },
                      );

                  if (context.mounted) {
                    Navigator.pop(context);
                  }

                  log(response.headers["content-type"] ?? "no content-type");
                  if (response.statusCode == 200) {
                    if (context.mounted) {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpCompletePage()));
                    }
                    log("회원 가입 완료");
                    log(response.body);
                  } else {
                    log("회원 가입 실패");
                    log(response.statusCode.toString());
                    log(response.body);
                  }
                }
              },
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
              child: const Text("회원가입"),
            ),
          ),
        ],
      ),
    );
  }
}

class SignUpCompletePage extends StatelessWidget {
  const SignUpCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("환영합니다!", style: TextStyle(fontSize: 32)),
            const SizedBox(height: 24, width: double.maxFinite),
            const Text("로그인을 통해 서비스를 이용해보세요!", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 36, width: double.maxFinite),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/sign-in", (route) => false);
                  },
                  style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
                  child: const Text("알겠습니다!"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
