import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../users/data/models/user_model.dart';

final userDetailsProvider = ChangeNotifierProvider.autoDispose(
  (ref) {
    return UserDetailsProvider();
  },
);

class UserDetailsProvider extends ChangeNotifier {
  bool _editMode = false;
  User? _currentUser;
  changeEditMode(bool modeValue) {
    _editMode = modeValue;
    notifyListeners();
  }

  changeCurrentUser(User user) {
    _currentUser = user;
    notifyListeners();
  }

  bool get editMode => _editMode;
  User? get currentUser => _currentUser;
}
