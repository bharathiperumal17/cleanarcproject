part of 'appuser_cubit.dart';

@immutable
sealed class AppuserState {}

final class AppuserInitial extends AppuserState {}

final class AppUserLoggedIn extends AppuserState {
  final User user;
  AppUserLoggedIn({required this.user});
}
