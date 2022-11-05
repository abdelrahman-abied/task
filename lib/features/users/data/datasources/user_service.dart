import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../../../../core/api/end_points.dart';
import '../../../../core/api/status_code.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/cache_helper.dart';
import '../../../../core/utils/constants.dart';
import '../../../../core/utils/log.dart';
import '../models/user_model.dart';
import '../models/user_model.dart';

abstract class UserService {
  Future<List<User>> getUser(int limit);
}

class UserServiceImpl extends UserService {
  @override
  Future<List<User>> getUser(int page) async {
    try {
      final response = await http.get(
        Uri.parse("${ApiEndPoints.User}?page=$page&limit=15"),
      );
      Log.d(page.toString());
      Log.d(response.body);
      if (response.statusCode == StatusCode.ok) {
        return userFromMap(response.body);
      } else if (response.statusCode == StatusCode.unauthorized) {
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      Log.e(e.toString());
      throw ServerException();
    }
  }
}
