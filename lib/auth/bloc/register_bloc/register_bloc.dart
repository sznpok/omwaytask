import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:omwaytech/auth/repo/register_repo.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<OnRegisterEvent>(onRegisterEvent);
  }

  FutureOr<void> onRegisterEvent(
      OnRegisterEvent event, Emitter<RegisterState> emit) async {
    RegisterRepo repo = RegisterRepo();
    emit(RegisterLoadingState());
    final result =
        await repo.register(event.userName!, event.email!, event.password!);
    if (result == true) {
      emit(RegisterSuccessState());
    } else {
      emit(RegisterErrorState("Failed to register"));
    }
  }
}
