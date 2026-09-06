import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      emit(AuthFailure(message: 'Please fill in all fields'));
      return;
    }

    emit(AuthLoading());

    // Simulate a network request since there is no real backend yet
    await Future.delayed(const Duration(seconds: 1));

    emit(AuthSuccess());
  }

  Future<void> register(
      String username,
      String password,
      String confirmPassword,
      ) async {
    if (username.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      emit(AuthFailure(message: 'Please fill in all fields'));
      return;
    }

    if (password != confirmPassword) {
      emit(AuthFailure(message: 'Passwords do not match'));
      return;
    }

    emit(AuthLoading());

    await Future.delayed(const Duration(seconds: 1));

    emit(AuthSuccess());
  }
}