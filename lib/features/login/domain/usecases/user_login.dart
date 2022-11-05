import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/repositories/login_repo_impl.dart';
import '../repositories/login_repository.dart';

final userLoginUseCaseProvider = Provider(
  (ref) {
    final loginRepo = ref.watch(loginRepoImplProvider);
    return UserLoginUseCase(loginRepo);
  },
);

class UserLoginUseCase implements UseCase<LoginStatus, Login> {
  final LoginRepository loginRepo;

  UserLoginUseCase(this.loginRepo);

  @override
  Future<Either<Failure, LoginStatus>> call(Login login) {
    return loginRepo.userLogin(login.email, login.password);
  }
}

class Login {
  final String email;
  final String password;

  Login(this.email, this.password);
}
