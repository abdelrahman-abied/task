import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';

import '../../data/models/user_model.dart';
import '../../data/repositories/user_repo_impl.dart';
import '../repositories/users_repository.dart';

final userUseCaseProvider = Provider(
  (ref) {
    final userRepo = ref.watch(UserRepoImplProvider);
    return GetUserUseCase(userRepo);
  },
);

class GetUserUseCase extends UseCase<List<User>, int> {
  final UserRepo userRepo;

  GetUserUseCase(this.userRepo);
  @override
  Future<Either<Failure, List<User>>> call(int page) => userRepo.getUser(page);
}
