part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class OnLoginEvent extends LoginEvent {
  final String userName;
  final String password;
  final String email;

  OnLoginEvent(
      {required this.password, required this.email, required this.userName});
}
