import 'package:flutter/material.dart';
import 'package:mobile/data/repository/auth_repository.dart';
import 'package:mobile/data/service/model/sign_in_response/sign_in_response.dart';
import 'package:mobile/utils/command.dart';
import 'package:mobile/utils/result.dart';

class SignInViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;
  late final Command1<void, (String email, String password)> signIn;

  String commonErrorText = "";

  SignInViewModel({required AuthRepository authRepository}) : _authRepository = authRepository {
    signIn = Command1<void, (String email, String password)>(_signIn);
  }

  bool get validated => commonErrorText.isEmpty;

  void validate({required String email, required String password}) {
    commonErrorText = "";

    _validate(email: email, password: password);

    notifyListeners();
  }

  Future<Result<void>> _signIn((String email, String password) credential) async {
    final (email, password) = credential;
    final Result result = await _authRepository.signIn(email: email, password: password);

    if (result is Error) {
      SignInResponse error = result.error;
      switch (error) {
        case UnAuthorized _:
        case ValidationError _:
          commonErrorText = "이메일 또는 비밀번호가 잘못 되었습니다.\n이메일과 비밀번호를 정확히 입력해 주세요.";
        case RequestTimeout _:
          commonErrorText = "문제가 발생했습니다.\n잠시 후 다시 시도해 주세요.";
        case UnknownError _:
          commonErrorText = "문제가 발생했습니다.\n문제가 반복된다면, 고객센터에 문의해주세요.";
      }
      notifyListeners();
    }

    return result;
  }

  void _validate({required String email, required String password}) {
    if (email.isEmpty) {
      commonErrorText = "이메일을 입력해 주세요.";
      return;
    }
    final emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]+$");
    if (!emailRegExp.hasMatch(email)) {
      commonErrorText = "이메일 또는 비밀번호가 잘못 되었습니다.\n이메일과 비밀번호를 정확히 입력해 주세요.";
      return;
    }

    if (password.isEmpty) {
      commonErrorText = "비밀번호를 입력해 주세요.";
      return;
    }
    final passwordRegExp = RegExp(r"""^[a-zA-Z0-9\-=\[\]\\;',\./~!@#\$%\^&\*\(\)_\+\{\}\|:"<>\?]{9,20}$""");
    if (!passwordRegExp.hasMatch(password)) {
      commonErrorText = "이메일 또는 비밀번호가 잘못 되었습니다.\n이메일과 비밀번호를 정확히 입력해 주세요.";
      return;
    }
  }
}
