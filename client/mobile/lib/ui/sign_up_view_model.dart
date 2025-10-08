import 'package:flutter/foundation.dart';
import 'package:mobile/data/repository/auth_repository.dart';

class SignUpViewModel extends ChangeNotifier {
  final AuthRepository _authRepository;

  SignUpViewModel({required AuthRepository authRepository}) : _authRepository = authRepository;
}
