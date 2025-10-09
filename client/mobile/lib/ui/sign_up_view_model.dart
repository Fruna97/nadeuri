import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:mobile/data/repository/auth_repository.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  String? _emailErrorText;
  bool _passwordErrorState = false;
  String? _passwordCheckErrorText;
  String? _nicknameErrorText;

  SignUpViewModel({required AuthRepository authRepository}) : _authRepository = authRepository;

  String? get emailErrorText => _emailErrorText;
  bool get passwordErrorState => _passwordErrorState;
  String? get passwordCheckErrorText => _passwordCheckErrorText;
  String? get nicknameErrorText => _nicknameErrorText;
  bool get allValidated =>
      (_emailErrorText == null) &&
      (_passwordErrorState == false) &&
      (_passwordCheckErrorText == null) &&
      (_nicknameErrorText == null);

  void validateEmail({required String email}) {
    _emailErrorText = null;

    if (email.isEmpty) {
      _emailErrorText = "이메일을 입력해 주세요.";
      notifyListeners();
      return;
    }

    final regExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]+$");
    if (!regExp.hasMatch(email)) {
      _emailErrorText = "올바른 형식의 이메일을 입력해 주세요.";
      notifyListeners();
      return;
    }

    notifyListeners();
  }

  void validatePassword({required String password, required String passwordCheck}) {
    _passwordErrorState = false;
    _passwordCheckErrorText = null;

    if (password.isEmpty) {
      _passwordErrorState = true;
      _passwordCheckErrorText = "비밀번호를 입력해 주세요.";
      notifyListeners();
      return;
    }

    final regExp = RegExp(r"""^[a-zA-Z0-9\-=\[\]\\;',\./~!@#\$%\^&\*\(\)_\+\{\}\|:"<>\?]{9,20}$""");
    if (!regExp.hasMatch(password)) {
      _passwordErrorState = true;
      _passwordCheckErrorText = "비밀번호는 9~20자의 영문, 숫자, 특수문자로 이루어져야 합니다.";
      notifyListeners();
      return;
    }

    if (passwordCheck.isEmpty) {
      _passwordCheckErrorText = "비밀번호 확인란을 입력해 주세요.";
      notifyListeners();
      return;
    }
    if (passwordCheck != password) {
      _passwordCheckErrorText = "비밀번호가 동일하지 않습니다.";
      notifyListeners();
      return;
    }

    notifyListeners();
  }

  void validateNickname({required String nickname}) {
    _nicknameErrorText = null;

    if (nickname.length > 20) {
      _nicknameErrorText = "별명은 20자 이하로 이루어져야 합니다.";
      notifyListeners();
      return;
    }

    notifyListeners();
  }
}
