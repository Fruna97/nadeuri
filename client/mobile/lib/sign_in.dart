import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/dto/token_data.dart';
import 'package:mobile/dto/validation_error_data.dart';
import 'package:provider/provider.dart';

import 'dto/response_dto.dart';
import 'api_service.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final ApiService _apiService;
  late final FlutterSecureStorage _flutterSecureStorage;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _errorText = '';

  bool _passwordObscureText = true;

  @override
  void initState() {
    _apiService = context.read<ApiService>();
    _flutterSecureStorage = context.read<FlutterSecureStorage>();

    super.initState();
  }

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
                    counterText: "", 
                  ),
                  maxLength: 320,
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                    suffixIcon: IconButton(
                      icon: Icon(_passwordObscureText ? Icons.visibility_off : Icons.visibility),
                      onPressed: () {
                        setState(() {
                          _passwordObscureText = !_passwordObscureText;
                        });
                      },
                    ),
                    border: OutlineInputBorder(),
                    counterText: "", 
                  ),
                  obscureText: _passwordObscureText,
                  maxLength: 20,
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
                if (_errorText.isNotEmpty) const SizedBox(height: 12.0),
                if (_errorText.isNotEmpty)
                  Center(
                    child: Text(
                      _errorText,
                      style: TextStyle(color: Colors.red, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: () async {
                    log("로그인 button pressed");

                    setState(() {
                      _errorText = "";
                    });

                    final String email = _emailController.text;
                    final String password = _passwordController.text;
                            
                    if (email.isEmpty) {
                      setState(() {
                        _errorText = "이메일을 입력해 주세요.";
                      });
                      return;
                    }
                    final emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]+$");
                    if (!emailRegExp.hasMatch(email)) {
                      setState(() {
                        _errorText =  "이메일 또는 비밀번호가 잘못 되었습니다.\n이메일과 비밀번호를 정확히 입력해 주세요.";
                      });
                      return;
                    }

                    if (password.isEmpty) {
                      setState(() {
                        _errorText = "비밀번호를 입력해 주세요.";
                      });
                      return;
                    }
                    final passwordRegExp = RegExp(r"""^[a-zA-Z0-9\-=\[\]\\;',\./~!@#\$%\^&\*\(\)_\+\{\}\|:"<>\?]{9,20}$""");
                    if (!passwordRegExp.hasMatch(password)) {
                      setState(() {
                        _errorText =  "이메일 또는 비밀번호가 잘못 되었습니다.\n이메일과 비밀번호를 정확히 입력해 주세요.";
                      });
                      return;
                    }

                    showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));

                    final http.Response? response;
                    response = await _apiService.post("/member/signin", {"email":email.trim(), "password":password.trim()});
                    
                    if (context.mounted) {
                      Navigator.pop(context);
                    }

                    if (response == null) {
                      setState(() {
                        _errorText = "문제가 발생했습니다.\n문제가 반복된다면, 고객센터에 문의해주세요.";
                      });
                      return;
                    }

                    final int statusCode = response.statusCode;
                    final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
                    log("StatusCode : $statusCode");

                    if (statusCode == HttpStatus.badRequest) {
                      try {
                        ResponseDto<ValidationErrorData> responseDto = ResponseDto.fromJson(
                          body,
                          (json) => ValidationErrorData.fromJson(json as Map<String, dynamic>),
                        );
                        setState(() {
                          _errorText = "이메일 또는 비밀번호가 잘못 되었습니다.\n이메일 또는 비밀번호 정확히 입력해 주세요.";
                        });
                        log("요청 본문 데이터 검증 오류: $responseDto");
                      } catch (e) {
                        setState(() {
                          _errorText = "문제가 발생했습니다.\n문제가 반복된다면, 고객센터에 문의해주세요.";
                        });
                        log("예외 상세: $e");
                      }
                      return;
                    }

                    if (statusCode == HttpStatus.unauthorized) {
                      setState(() {
                        _errorText = "이메일 또는 비밀번호가 잘못 되었습니다.\n이메일 또는 비밀번호 정확히 입력해 주세요.";
                      });
                      return;
                    }

                    if (statusCode == HttpStatus.requestTimeout) {
                      setState(() {
                        _errorText = "문제가 발생했습니다.\n잠시 후 다시 시도해 주세요.";
                      });
                      return;
                    }

                    if (statusCode != HttpStatus.ok) {
                      setState(() {
                        _errorText = "문제가 발생했습니다.\n문제가 반복된다면, 고객센터에 문의해주세요.";
                      });
                      return;
                    }

                    final ResponseDto<TokenData> responseDto;
                    try {
                      responseDto = ResponseDto.fromJson(
                        body,
                        (json) => TokenData.fromJson(json as Map<String, dynamic>),
                      );
                    } catch (e) {
                      setState(() {
                        _errorText = "문제가 발생했습니다.\n문제가 반복된다면, 고객센터에 문의해주세요.";
                      });
                      return;
                    }

                    await _flutterSecureStorage.write(key: "accessToken", value: responseDto.data!.accessToken);
                    await _flutterSecureStorage.write(key: "refreshToken", value: responseDto.data!.refreshToken);
                    
                    log("로그인 성공");
                    // TODO: 메인화면으로 이동
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
