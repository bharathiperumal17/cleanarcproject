import 'package:cleanarcproject/core/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'appuser_state.dart';

class AppuserCubit extends Cubit<AppuserState> {
  AppuserCubit() : super(AppuserInitial());

  void updateUser(User? user) {
    if (user == null) {
      emit(AppuserInitial());
    } else {
      emit(AppUserLoggedIn(user: user));
    }
  }
}
