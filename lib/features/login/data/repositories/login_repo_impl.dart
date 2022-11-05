import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/netwok_info.dart';
import '../../../../global_state.dart';
import '../../domain/repositories/login_repository.dart';
import '../datasources/login_service.dart';

final loginRepoImplProvider = Provider(
  (ref) {
    final networkInfo = ref.watch(networkInfoProvider);

    return LoginRepoImpl(
      loginService: LoginServiceImpl(),
      networkInfo: networkInfo,
    );
  },
);

class LoginRepoImpl extends LoginRepository {
  final NetworkInfo networkInfo;
  final LoginService loginService;

  LoginRepoImpl({required this.networkInfo, required this.loginService});
  @override
  Future<Either<Failure, LoginStatus>> userLogin(
      String email, String password) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        final Usertatus =
            await loginService.userlogin(email: email, password: password);

        return Right(Usertatus);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
