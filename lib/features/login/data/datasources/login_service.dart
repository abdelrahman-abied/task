import 'dart:convert';

import 'package:e_butler_task/core/utils/log.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../../../core/api/end_points.dart';
import '../../../../core/api/status_code.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/constants.dart';

abstract class LoginService {
  Future<LoginStatus> userlogin(
      {required String email, required String password});
}

class LoginServiceImpl implements LoginService {
  @override
  Future<LoginStatus> userlogin(
      {required String email, required String password}) async {
    try {
      saveUserAuth(email);
      return LoginStatus.authenticated;
    } on ServerException {
      return LoginStatus.unauthenticated;
    }
  }

  checkUserAutherization() {
    CacheHelper.getPrefs(key: Constants.KLastLoginTimeKey);
  }

  void saveUserAuth(String email) {
    final currentTime = DateTime.now().toString();

    CacheHelper.savePrefs(key: Constants.KLastLoginTimeKey, value: currentTime);
    CacheHelper.savePrefs(key: Constants.KEmail, value: email);
  }
}
