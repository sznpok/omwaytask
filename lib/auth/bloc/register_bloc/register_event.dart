part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class OnRegisterEvent extends RegisterEvent {
  final String? userName;
  final String? email;
  final String? password;

  OnRegisterEvent({this.password, this.email, this.userName});
}
