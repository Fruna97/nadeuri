import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/api_service.dart';
import 'package:mobile/dto/response_dto.dart';
import 'package:mobile/dto/validation_error_data.dart';
import 'package:mobile/ui/sign_up_view_model.dart';
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
  final FocusNode _nicknameFocusNode = FocusNode();

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

    _emailFocusNode.addListener(_validateOnEmailFocusLost);
    _passwordFocusNode.addListener(_validateOnPasswordFocusLost);
    _passwordCheckFocusNode.addListener(_validateOnPasswordCheckFocusLost);
    _nicknameFocusNode.addListener(_validateOnNicknameFocusLost);

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
              errorText: context.select((SignUpViewModel viewModel) => viewModel.emailErrorText),
              border: OutlineInputBorder(),
              counterText: "",
            ),
            maxLength: 320,
          ),
          const SizedBox(height: 24.0),
          TextFormField(
            key: _passwordKey,
            controller: _passwordController,
            focusNode: _passwordFocusNode,
            decoration: InputDecoration(
              labelText: "비밀번호",
              error: context.select((SignUpViewModel viewModel) => viewModel.passwordErrorState) ? SizedBox.shrink() : null,
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
              errorText: context.select((SignUpViewModel viewModel) => viewModel.passwordCheckErrorText),
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
          ),
          const SizedBox(height: 24.0),
          TextFormField(
            controller: _nicknameController,
            focusNode: _nicknameFocusNode,
            decoration: InputDecoration(
              labelText: "별명",
              helperText: "별명을 입력하지 않으시면, 이메일을 기반으로 자동으로 생성됩니다.",
              errorText: context.select((SignUpViewModel viewModel) => viewModel.nicknameErrorText),
              border: const OutlineInputBorder(),
              counterText: "",
            ),
            maxLength: 20,
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
              final String email = _emailController.text;
              final String password = _passwordController.text;
              final String passwordCheck = _passwordCheckController.text;
              final String nickname = _nicknameController.text;

              setState(() {
                _errorText = "";
              });

              context.read<SignUpViewModel>().validateEmail(email: email);
              context.read<SignUpViewModel>().validatePassword(password: password, passwordCheck: passwordCheck);
              context.read<SignUpViewModel>().validateNickname(nickname: nickname);

              if (!context.read<SignUpViewModel>().allValidated) {
                return;
              }

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
                    // if (responseDto.data!.password != null) _activatePasswordErrorState(); // TODO: ViewModel 도입을 통해 수정 예정
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

  void _validateOnEmailFocusLost() {
    if (!_emailFocusNode.hasFocus) {
      context.read<SignUpViewModel>().validateEmail(email: _emailController.text);
    }
  }

  void _validateOnPasswordFocusLost() {
    if (!_passwordFocusNode.hasFocus) {
      context.read<SignUpViewModel>().validatePassword(
        password: _passwordController.text,
        passwordCheck: _passwordCheckController.text,
      );
    }
  }

  void _validateOnPasswordCheckFocusLost() {
    if (!_passwordCheckFocusNode.hasFocus) {
      context.read<SignUpViewModel>().validatePassword(
        password: _passwordController.text,
        passwordCheck: _passwordCheckController.text,
      );
    }
  }

  void _validateOnNicknameFocusLost() {
    if (!_nicknameFocusNode.hasFocus) {
      context.read<SignUpViewModel>().validateNickname(nickname: _nicknameController.text);
    }
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
