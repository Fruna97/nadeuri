import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/api_service.dart';
import 'package:mobile/dto/response_dto.dart';
import 'package:mobile/dto/validation_error_data.dart';
import 'package:provider/provider.dart';

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

  late final ApiService _apiService;

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
  String? _nicknameErrorText;

  bool _passwordObscureText = true;
  bool _passwordCheckObscureText = true;

  String _errorText = '';

  @override
  void initState() {
    _apiService = context.read<ApiService>();

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

    super.initState();
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
              _deactivatePasswordErrorState();

              String password = _passwordController.text;
              if (password.isEmpty) {
                _activatePasswordErrorState();
                return "비밀번호를 입력해 주세요.";
              }
              final regExp = RegExp(r"""^[a-zA-Z0-9\-=\[\]\\;',\./~!@#\$%\^&\*\(\)_\+\{\}\|:"<>\?]{9,20}$""");
              if (!regExp.hasMatch(password)) {
                _activatePasswordErrorState();
                return "비밀번호는 9~20자의 영문, 숫자, 특수문자로 이루어져야 합니다.";
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
            decoration: InputDecoration(
              labelText: "별명",
              helperText: "별명을 입력하지 않으시면, 이메일을 기반으로 자동으로 생성됩니다.",
              errorText: _nicknameErrorText,
              border: const OutlineInputBorder(),
              counterText: "",
            ),
            maxLength: 20,
            validator: (String? nickname) {
              if (nickname != null && nickname.length > 20) {
                return "별명은 20자 이하로 이루어져야 합니다.";
              }

              return null;
            },
          ),
          if (_errorText.isNotEmpty) const SizedBox(height: 12),
          if (_errorText.isNotEmpty)
            Center(
              child: Text(
                _errorText, 
                style: TextStyle(color: Colors.red, fontSize: 12), 
                textAlign: TextAlign.center
              ),
            ),
          const SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: () async {
              setState(() {
                _errorText = "";
                _deactivatePasswordErrorState();
                _emailErrorText = null;
                _passwordCheckErrorText = null;
                _nicknameErrorText = null;
              });

              if (!_formKey.currentState!.validate()) {
                return;
              }

              final String email = _emailController.text;
              final String password = _passwordController.text;
              final String nickname = _nicknameController.text;

              showDialog(
                context: context,
                builder: (context) => PopScope(canPop: false, child: Center(child: CircularProgressIndicator())),
                barrierDismissible: false,
              );

              http.Response? response;
              response = await _apiService.post("/member/signup", {"email":email.trim(), "password":password.trim(), "nickname":nickname.trim()});

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
                    _emailErrorText = responseDto.data!.email?.join("\n");
                    if (responseDto.data!.password != null) _activatePasswordErrorState();
                    _passwordCheckErrorText = responseDto.data!.password?.join("\n");
                    _nicknameErrorText = responseDto.data!.nickname?.join("\n");
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

              if (statusCode == HttpStatus.requestTimeout) {
                setState(() {
                  _errorText = "문제가 발생했습니다.\n잠시 후 다시 시도해 주세요.";
                });
                return;
              }

              if (statusCode == HttpStatus.conflict) {
                ResponseDto<Null> responseDto = ResponseDto.fromJson(body, (json) => null);
                setState(() {
                  _emailErrorText = "이미 가입된 이메일 입니다.";
                });
                log("중복 이메일 가입 요청: $responseDto");
                return;
              }

              if (statusCode != HttpStatus.ok) {
                setState(() {
                  _errorText = "문제가 발생했습니다.\n문제가 반복된다면, 고객센터에 문의해주세요.";
                });
                return;
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
      _passwordError = null;
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
