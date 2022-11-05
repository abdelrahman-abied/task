import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/netwok_info.dart';
import '../../../../global_state.dart';
import '../../domain/repositories/users_repository.dart';
import '../datasources/user_service.dart';
import '../datasources/user_service.dart';

import '../models/user_model.dart';

final UserRepoImplProvider = Provider(
  (ref) {
    final networkInfo = ref.watch(networkInfoProvider);
    return UserRepoImpl(
      networkInfo: networkInfo,
      userService: UserServiceImpl(),
    );
  },
);

class UserRepoImpl extends UserRepo {
  final NetworkInfo networkInfo;
  final UserService userService;

  UserRepoImpl({required this.networkInfo, required this.userService});

  @override
  Future<Either<Failure, List<User>>> getUser(int page) async {
    {
      bool isConnected = await networkInfo.isConnected;
      if (isConnected) {
        try {
          final User = await userService.getUser(page);
          return Right(User);
        } on UnauthorizedException {
          return Left(ServerFailure());
        } on ServerException {
          return Left(UnutheriztionFailure());
        }
      } else {
        return Left(NetworkFailure());
      }
    }
  }
}
