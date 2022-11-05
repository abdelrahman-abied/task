import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/error/failures.dart';
import '../../../../features/login/presentation/provider/login_provider.dart';

import '../../../../core/constants/constants.dart';

import '../../data/models/user_model.dart';
import '../../domain/usecases/get_user.dart';

// final UserProvider = StateNotifierProvider<UserProvider, List<User>>((ref) {
//   final UserUseCase = ref.watch(UserUseCaseProvider);
//   return UserProvider(UserUseCase);
// });
final userProvider = ChangeNotifierProvider((ref) {
  final UserUseCase = ref.watch(userUseCaseProvider);
  return UserProvider(userUseCase: UserUseCase, ref: ref);
});

class UserProvider extends ChangeNotifier {
  // Initialize the list of User to an empty list
  final Ref ref;
  UserProvider({
    required this.userUseCase,
    required this.ref,
  });

  List<User> _user = [];

  int page = 0;
  bool isLoading = false;
  bool isInternetFailed = false;
  bool isUserAutherized = true;

  final GetUserUseCase userUseCase;
  getUsers() async {
    page = page += 1;
    isLoading = true;
    notifyListeners();
    final response = await userUseCase(page);

    response.fold((failure) {
      if (failure == UnutheriztionFailure()) {
        isUserAutherized = false;
        _user.clear();
        ref
            .read(userLoginProvider)
            .changeUserAutherization(LoginStatus.unknown);
        isLoading = false;

        notifyListeners();
      } else {
        _user.clear();
        isInternetFailed = true;
        isLoading = false;
        notifyListeners();
      }
    }, (user) {
      _user = List.from(_user)..addAll(user);

      isLoading = false;
      notifyListeners();
    });
  }

  void updateUsers(User user) {
    _user[_user.indexWhere((element) => element.id == user.id)] = user;
    notifyListeners();
  }

  List<User> get user => _user;
}
