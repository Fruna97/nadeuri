import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile/dto/response_dto.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Center(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 12.0), child: SignUpForm()))));
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
  final TextEditingController _nicknameController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordCheckFocusNode = FocusNode();

  Widget? _passwordError;

  String? _emailErrorText;
  String? _passwordCheckErrorText;

  bool _passwordObscureText = true;
  bool _passwordCheckObscureText = true;

  String _errorText = '';

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        if (_emailErrorText != null) {
          setState(() {
            _emailErrorText = null;
          });
        }
        _emailKey.currentState?.validate();
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        if (_passwordCheckErrorText != null) {
          setState(() {
            _passwordCheckErrorText = null;
          });
        }
        _passwordCheckKey.currentState?.validate();
      }
    });
    _passwordCheckFocusNode.addListener(() {
      if (!_passwordCheckFocusNode.hasFocus) {
        if (_passwordCheckErrorText != null) {
          setState(() {
            _passwordCheckErrorText = null;
          });
        }
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text("회원가입", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))],
          ),
          SizedBox(height: 40),
          TextFormField(
            key: _emailKey,
            controller: _emailController,
            focusNode: _emailFocusNode,
            decoration: InputDecoration(
              labelText: "이메일",
              helperText: "추후 이메일을 통해 비밀번호를 재설정 하실 수 있습니다.",
              errorText: _emailErrorText,
              border: OutlineInputBorder(),
              counterText: "", 
            ),
            maxLength: 320,
            validator: (String? email) {
              if (email == null || email.isEmpty) {
                return "이메일을 입력해 주세요.";
              }
          
              final regExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]+$");
              if (!regExp.hasMatch(email)) {
                // 정규 표현식을 사용하여 이메일 형식 검증
                return "올바른 형식의 이메일을 입력해 주세요.";
              }
          
              return null;
            },
          ),
          const SizedBox(height: 24.0),
          TextFormField(
            key: _passwordKey,
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            decoration: InputDecoration(
              labelText: "비밀번호",
              error: _passwordError, // "비밀번호 확인" 필드에서 error 상태를 조절하기 위한 state
              suffixIcon: IconButton(
                icon: Icon(_passwordObscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _passwordObscureText = !_passwordObscureText;
                  });
                },
              ),
              border: const OutlineInputBorder(),
              counterText: "", 
            ),
            obscureText: _passwordObscureText,
            maxLength: 20,
          ),
          const SizedBox(height: 6.0),
          TextFormField(
            key: _passwordCheckKey,
            controller: _passwordCheckController,
            focusNode: _passwordCheckFocusNode,
            decoration: InputDecoration(
              labelText: "비밀번호 확인",
              errorText: _passwordCheckErrorText,
              suffixIcon: IconButton(
                icon: Icon(_passwordCheckObscureText ? Icons.visibility_off : Icons.visibility),
                onPressed: () {
                  setState(() {
                    _passwordCheckObscureText = !_passwordCheckObscureText;
                  });
                },
              ),
              border: OutlineInputBorder(),
              counterText: "", 
            ),
            obscureText: _passwordCheckObscureText,
            maxLength: 20,
            validator: (String? passwordCheck) { // "비밀번호" 필드와 "비밀번호 확인" 필드의 검증 메시지 모두 "비밀번호 확인" 필드 아래에 표시
              String password = _passwordController.text;
              if (password.isEmpty) {
                _activatePasswordErrorState();
                return "비밀번호를 입력해 주세요.";
              } 
              final regExp = RegExp(r"""^[a-zA-Z0-9\-=\[\]\\;',\./~!@#\$%\^&\*\(\)_\+\{\}\|:"<>\?]{9,20}$""");
              if (!regExp.hasMatch(password)) {
                return "비밀번호는 9~20자의 영문, 숫자, 특수문자로 이루어져야 합니다.";
              }
              if (_passwordError != null) { // 재검증시 비밀번호 필드에 이상이 없는 경우
                _deactivatePasswordErrorState();
              }
          
          
              if (passwordCheck == null || passwordCheck.isEmpty) {
                return "비밀번호 확인란을 입력해 주세요.";
              }
              if (password != passwordCheck) {
                return "비밀번호가 동일하지 않습니다.";
              }
          
              return null;
            },
          ),
          const SizedBox(height: 24.0),
          TextFormField(
            controller: _nicknameController,
            decoration: const InputDecoration(
              labelText: "별명",
              helperText: "별명을 입력하지 않으시면, 이메일을 기반으로 자동으로 생성됩니다.",
              border: OutlineInputBorder(),
              counterText: "", 
            ),
            maxLength: 20,
            validator: (String? nickname) {
              if (nickname != null && nickname.length > 20) {
                return "별명은 20자 이하로 이루어져야 합니다.";
              }
            },
          ),
          if (_errorText.isNotEmpty) const SizedBox(height: 12), 
          if (_errorText.isNotEmpty) Center(child: Text(_errorText, style: TextStyle(color: Colors.red, fontSize: 12))),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () async {
              if (!_formKey.currentState!.validate()) {
                return ;
              }
          
              _errorText = '';
          
              showDialog(context: context, builder: (context) => const Center(child: CircularProgressIndicator()));
          
              Response response;
              try {
                response = await http
                    .post(
                      // Uri.parse("http://localhost:8080/member/signup"), // Chrome
                      Uri.parse("http://10.0.2.2:8080/member/signup"), // Android
                      headers: {"content-type": "application/json;charset=UTF-8"},
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
              } catch (e) {
                log(e.toString());
                setState(() {
                  _errorText = "문제가 발생했습니다. 문제가 반복된다면, 고객센터에 문의해주세요.";
                });
          
                return ;
              } finally {
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
          
              final statusCode = response.statusCode;
              dynamic body;
              ResponseDto<Map<String, List<String>>?> responseDto;
              try {
                body = jsonDecode(response.body);
                responseDto = ResponseDto.fromJson(body,ResponseDto.dataFromFieldValidation);
              } catch (e) {
                log(e.toString());
                setState(() {
                  _errorText = "문제가 발생했습니다. 문제가 반복된다면, 고객센터에 문의해주세요.";
                });
          
                return ;
              }
              log("Status Code : $statusCode");
              log("Response Data : ${responseDto.toString()}");
              
              if (statusCode == HttpStatus.requestTimeout) {
                log("요청 타임아웃");
                setState(() {
                  _errorText = "문제가 발생했습니다. 잠시 후 다시 시도해 주세요.";
                });
          
                return ;
              }
          
              if (statusCode != HttpStatus.ok) {
                log("회원가입 실패");
          
                // 회원가입을 실패하면 응답에 따라 각 텍스트 필드에 검증 에러 메시지 표시
                if (responseDto.message.startsWith("이미 존재하는 이메일 입니다")) {
                  setState(() {
                    _emailErrorText = "이미 가입된 이메일 입니다.";
                  });
                  _emailFocusNode.requestFocus();
                } else if (responseDto.message.startsWith("유효성 검사 실패")) {
                  responseDto.data!.forEach((key, value) {
                    String errorText = "";
                    value.forEach((item) {
                      errorText += item + "\n";
                    });
          
                    setState(() {
                      switch (key) {
                        case "email":
                          _emailErrorText = errorText;
                        case "password":
                          _activatePasswordErrorState();
                          _passwordCheckErrorText = errorText;
                      }
                    });
                  });
                }
          
                return ;
              }
          
              log("회원가입 성공");
              // 회원가입 성공시 회원가입 완료 페이지로 전환
              if (context.mounted) {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpCompletePage()));
              }
            },
            style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
            child: const Text("회원가입"),
          ),
        ],
      ),
    );
  }

  void _activatePasswordErrorState() {
    setState(() {
      _passwordError ??= SizedBox.shrink();
    });
  }

  void _deactivatePasswordErrorState() {
    setState(() {
      if (_passwordError != null) {
        _passwordError = null;
      }
    });
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
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
                  ),
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
