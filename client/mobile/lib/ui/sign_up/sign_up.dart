import 'package:flutter/material.dart';
import 'package:mobile/ui/sign_up/sign_up_view_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final SignUpViewModel _signUpViewModel;

  @override
  void initState() {
    super.initState();

    _signUpViewModel = context.read<SignUpViewModel>();

    _signUpViewModel.signUp.addListener(_navigateOnSignUpComplete);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: _signUpViewModel.signUp,
        builder: (context, child) {
          return Stack(
            fit: StackFit.expand,
            children: [
              SafeArea(child: child!),
              if (_signUpViewModel.signUp.running) ...[
                ModalBarrier(dismissible: false, color: Colors.black45),
                const Center(child: CircularProgressIndicator()),
              ],
            ],
          );
        },
        child: SignUpForm(signUpViewModel: _signUpViewModel),
      ),
    );
  }

  @override
  void dispose() {
    _signUpViewModel.signUp.removeListener(_navigateOnSignUpComplete);

    super.dispose();
  }

  void _navigateOnSignUpComplete() {
    if (_signUpViewModel.signUp.completed && mounted) {
      _signUpViewModel.signUp.clearResult();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpCompletePage()));
    }
  }
}

class SignUpForm extends StatefulWidget {
  final SignUpViewModel _signUpViewModel;

  const SignUpForm({super.key, required SignUpViewModel signUpViewModel}) : _signUpViewModel = signUpViewModel;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();

  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordCheckFocusNode = FocusNode();
  final FocusNode _nicknameFocusNode = FocusNode();

  bool _passwordObscureText = true;
  bool _passwordCheckObscureText = true;

  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(_validateOnEmailFocusLost);
    _passwordFocusNode.addListener(_validateOnPasswordFocusLost);
    _passwordCheckFocusNode.addListener(_validateOnPasswordCheckFocusLost);
    _nicknameFocusNode.addListener(_validateOnNicknameFocusLost);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Text("회원가입", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold))],
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: _emailController,
              focusNode: _emailFocusNode,
              decoration: InputDecoration(
                labelText: "이메일",
                helperText: "추후 이메일을 통해 비밀번호를 재설정 하실 수 있습니다.",
                errorText: context.select((SignUpViewModel viewModel) => viewModel.emailErrorText),
                border: const OutlineInputBorder(),
                counterText: "",
              ),
              textInputAction: TextInputAction.next,
              maxLength: 320,
            ),
            const SizedBox(height: 24.0),
            TextFormField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              decoration: InputDecoration(
                labelText: "비밀번호",
                error: context.select((SignUpViewModel viewModel) => viewModel.passwordErrorState)
                    ? SizedBox.shrink()
                    : null,
                suffixIcon: ExcludeFocus(
                  child: IconButton(
                    icon: Icon(_passwordObscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _passwordObscureText = !_passwordObscureText;
                      });
                    },
                  ),
                ),
                border: const OutlineInputBorder(),
                counterText: "",
              ),
              textInputAction: TextInputAction.next,
              obscureText: _passwordObscureText,
              maxLength: 20,
            ),
            const SizedBox(height: 6.0),
            TextFormField(
              controller: _passwordCheckController,
              focusNode: _passwordCheckFocusNode,
              decoration: InputDecoration(
                labelText: "비밀번호 확인",
                errorText: context.select((SignUpViewModel viewModel) => viewModel.passwordCheckErrorText),
                suffixIcon: ExcludeFocus(
                  child: IconButton(
                    icon: Icon(_passwordCheckObscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _passwordCheckObscureText = !_passwordCheckObscureText;
                      });
                    },
                  ),
                ),
                border: const OutlineInputBorder(),
                counterText: "",
              ),
              textInputAction: TextInputAction.next,
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
            if (context.select((SignUpViewModel viewModel) => viewModel.commonErrorText).isNotEmpty) ...[
              const SizedBox(height: 12),
              Center(
                child: Text(
                  context.select((SignUpViewModel viewModel) => viewModel.commonErrorText),
                  style: TextStyle(color: Colors.red, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            const SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () async {
                FocusScope.of(context).unfocus();

                final String email = _emailController.text;
                final String password = _passwordController.text;
                final String passwordCheck = _passwordCheckController.text;
                final String nickname = _nicknameController.text;

                // 필드 유효성 검증
                widget._signUpViewModel.validateAll(
                  email: email,
                  password: password,
                  passwordCheck: passwordCheck,
                  nickname: nickname,
                );
                if (!widget._signUpViewModel.allValidated) {
                  return;
                }

                // 유효성 검증 완료 시 회원가입 요청 전송
                widget._signUpViewModel.signUp.execute((email, password, nickname));
              },
              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0))),
              child: const Text("회원가입"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailFocusNode.removeListener(_validateOnEmailFocusLost);
    _passwordFocusNode.removeListener(_validateOnPasswordFocusLost);
    _passwordCheckFocusNode.removeListener(_validateOnPasswordCheckFocusLost);
    _nicknameFocusNode.removeListener(_validateOnNicknameFocusLost);

    super.dispose();
  }

  void _validateOnEmailFocusLost() {
    if (!_emailFocusNode.hasFocus) {
      widget._signUpViewModel.validateEmail(email: _emailController.text);
    }
  }

  void _validateOnPasswordFocusLost() {
    if (!_passwordFocusNode.hasFocus) {
      widget._signUpViewModel.validatePassword(
        password: _passwordController.text,
        passwordCheck: _passwordCheckController.text,
      );
    }
  }

  void _validateOnPasswordCheckFocusLost() {
    if (!_passwordCheckFocusNode.hasFocus) {
      widget._signUpViewModel.validatePassword(
        password: _passwordController.text,
        passwordCheck: _passwordCheckController.text,
      );
    }
  }

  void _validateOnNicknameFocusLost() {
    if (!_nicknameFocusNode.hasFocus) {
      widget._signUpViewModel.validateNickname(nickname: _nicknameController.text);
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
