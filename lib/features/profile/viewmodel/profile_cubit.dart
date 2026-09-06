import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

  String name = 'Salem Ramadan';

  void loadProfile() {
    emitLoaded();
  }

  void changeName(String newName) {
    name = newName;
    emitLoaded();
  }

  void emitLoaded() {
    emit(ProfileLoaded(name: name));
  }
}
