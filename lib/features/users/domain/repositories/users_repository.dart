import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/user_model.dart';

abstract class UserRepo {
  Future<Either<Failure, List<User>>> getUser(int page);
}
