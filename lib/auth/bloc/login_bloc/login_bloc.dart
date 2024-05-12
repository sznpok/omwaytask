import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:omwaytech/auth/repo/login_repo.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnLoginEvent>(onLoginEvent);
  }

  FutureOr<void> onLoginEvent(
      OnLoginEvent event, Emitter<LoginState> emit) async {
    LoginRepo loginRepo = LoginRepo();
    emit(LoginLoadingState());
    final result =
        await loginRepo.login(event.userName, event.email, event.password);

    if (result == true) {
      emit(LoginSuccessState());
    } else {
      emit(LoginErrorState("Failed to Login"));
    }
  }
}
