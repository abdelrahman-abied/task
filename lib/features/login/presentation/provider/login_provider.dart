import 'package:e_butler_task/core/utils/log.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../domain/usecases/user_login.dart';

final userLoginProvider = ChangeNotifierProvider(
  (ref) {
    final userLoginUseCase = ref.watch(userLoginUseCaseProvider);
    return LoginProvider(userLoginUseCase);
  },
);

class LoginProvider extends ChangeNotifier {
  final UserLoginUseCase loginUseCase;

  late LoginStatus _usertatus;

  LoginProvider(this.loginUseCase) {
    _usertatus = CacheHelper.getPrefs(key: Constants.KEmail).toString().isEmpty
        ? LoginStatus.unauthenticated
        : LoginStatus.authenticated;
  }

  Future<LoginStatus> login(
      {required String email, required String password}) async {
    final response = await loginUseCase.call(Login(email, password));
    response.fold((failure) {
      _usertatus = LoginStatus.unauthenticated;
      notifyListeners();
    }, (loginStatus) {
      _usertatus = LoginStatus.authenticated;
      notifyListeners();
    });

    return _usertatus;
  }

  void checkUsertatus() {
    try {
      final userEmail = CacheHelper.getPrefs(key: Constants.KEmail).toString();
      final lastLogin =
          CacheHelper.getPrefs(key: Constants.KLastLoginTimeKey).toString();
      if (userEmail.isNotEmpty || lastLogin.isNotEmpty) {
        final lastLoginDate = DateTime.parse(lastLogin);
        Log.d(lastLogin.toString());
        final bool isAuth =
            lastLoginDate.difference(DateTime.now()).inHours > 1;
        if (isAuth) {
          _usertatus = LoginStatus.authenticated;
          notifyListeners();
        }
      } else {
        _usertatus = LoginStatus.unauthenticated;
        notifyListeners();
      }
    } catch (e) {
      _usertatus = LoginStatus.unauthenticated;
      notifyListeners();
    }
  }

  void changeUserAutherization(LoginStatus loginStatus) {
    _usertatus = loginStatus;
    notifyListeners();
  }

  LoginStatus get usertatus => _usertatus;
}
