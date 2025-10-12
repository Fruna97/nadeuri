import 'package:flutter/foundation.dart';
import 'package:mobile/data/repository/auth_repository.dart';
import 'package:mobile/data/service/model/api_error/api_error.dart';
import 'package:mobile/utils/command.dart';
import 'package:mobile/utils/result.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  late final Command1<void, (String email, String password, String nickname)> signUp;

  String? _emailErrorText;
  bool _passwordErrorState = false;
  String? _passwordCheckErrorText;
  String? _nicknameErrorText;
  String _commonErrorText = "";

  SignUpViewModel({required AuthRepository authRepository}) : _authRepository = authRepository {
    signUp = Command1<void, (String email, String password, String nickname)>(_signUp);
  }

  String? get emailErrorText => _emailErrorText;
  bool get passwordErrorState => _passwordErrorState;
  String? get passwordCheckErrorText => _passwordCheckErrorText;
  String? get nicknameErrorText => _nicknameErrorText;
  String get commonErrorText => _commonErrorText;
  bool get allValidated =>
      (_emailErrorText == null) &&
      (_passwordErrorState == false) &&
      (_passwordCheckErrorText == null) &&
      (_nicknameErrorText == null);

  @override
  void dispose() {
    signUp.dispose();

    super.dispose();
  }

  void validateEmail({required String email}) {
    _validateEmail(email: email);
    notifyListeners();
  }

  void validatePassword({required String password, required String passwordCheck}) {
    _validatePassword(password: password, passwordCheck: passwordCheck);

    notifyListeners();
  }

  void validateNickname({required String nickname}) {
    _validateNickname(nickname: nickname);

    notifyListeners();
  }

  void validateAll({
    required String email,
    required String password,
    required String passwordCheck,
    required String nickname,
  }) {
    _resetCommonErrorState();

    _validateEmail(email: email);
    _validatePassword(password: password, passwordCheck: passwordCheck);
    _validateNickname(nickname: nickname);

    notifyListeners();
  }

  Future<Result<void>> _signUp((String email, String password, String nickname) member) async {
    final (email, password, nickname) = member;
    final Result result = await _authRepository.signUp(email: email, password: password, nickname: nickname);

    if (result is Error) {
      Exception error = result.error;
      switch (error) {
        case RequestTimeout _:
          _commonErrorText = "문제가 발생했습니다.\n잠시 후 다시 시도해 주세요.";
        case DuplicateEmail _:
          _emailErrorText = "이미 가입된 이메일 입니다.";
        case ValidationError _:
          _emailErrorText = error.email?.join("\n");
          _passwordCheckErrorText = error.password?.join("\n");
          _nicknameErrorText = error.nickname?.join("\n");
        case UnknownError _:
          _commonErrorText = "문제가 발생했습니다.\n문제가 반복된다면, 고객센터에 문의해주세요.";
      }
      notifyListeners();
    }

    return result;
  }

  void _validateEmail({required String email}) {
    _resetEmailErrorState();

    if (email.isEmpty) {
      _emailErrorText = "이메일을 입력해 주세요.";
      return;
    }

    final regExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]+$");
    if (!regExp.hasMatch(email)) {
      _emailErrorText = "올바른 형식의 이메일을 입력해 주세요.";
      return;
    }
  }

  void _validatePassword({required String password, required String passwordCheck}) {
    _resetPasswordErrorState();

    if (password.isEmpty) {
      _passwordErrorState = true;
      _passwordCheckErrorText = "비밀번호를 입력해 주세요.";
      return;
    }
    final regExp = RegExp(r"""^[a-zA-Z0-9\-=\[\]\\;',\./~!@#\$%\^&\*\(\)_\+\{\}\|:"<>\?]{9,20}$""");
    if (!regExp.hasMatch(password)) {
      _passwordErrorState = true;
      _passwordCheckErrorText = "비밀번호는 9~20자의 영문, 숫자, 특수문자로 이루어져야 합니다.";
      return;
    }

    if (passwordCheck.isEmpty) {
      _passwordCheckErrorText = "비밀번호 확인란을 입력해 주세요.";
      return;
    }
    if (passwordCheck != password) {
      _passwordCheckErrorText = "비밀번호가 동일하지 않습니다.";
      return;
    }
  }

  void _validateNickname({required String nickname}) {
    _resetNicknameErrorState();

    if (nickname.length > 20) {
      _nicknameErrorText = "별명은 20자 이하로 이루어져야 합니다.";
      return;
    }
  }

  void _resetEmailErrorState() {
    _emailErrorText = null;
  }

  void _resetPasswordErrorState() {
    _passwordErrorState = false;
    _passwordCheckErrorText = null;
  }

  void _resetNicknameErrorState() {
    _nicknameErrorText = null;
  }

  void _resetCommonErrorState() {
    _commonErrorText = "";
  }
}
