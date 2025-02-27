import 'dart:developer';

import 'package:book_heaven/local_user/local_user.dart';
import 'package:book_heaven/models/models.dart';
import 'package:book_heaven/presentation/screens/profile/event.dart';
import 'package:book_heaven/presentation/screens/profile/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LocalUser _localUser = LocalUser();

  ProfileBloc() : super(ProfileState.initial()) {
    on<LoadProfileEvent>(_loadUserProfile);
    on<LogoutEvent>(_logout);
  }

  Future<void> _loadUserProfile(
      LoadProfileEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.clone(status: ProfileStatus.loading));

      final LocalUserModel? user = await _localUser.getUser();
      if (user != null) {
        emit(state.clone(user: user, status: ProfileStatus.loaded));
      } else {
        emit(state.clone(status: ProfileStatus.error));
      }
    } catch (e) {
   
      emit(state.clone(status: ProfileStatus.error));
    }
  }

  Future<void> _logout(LogoutEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(state.clone(status: ProfileStatus.loading));
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
      emit(state.clone(user: null, status: ProfileStatus.loggedOut));
    } catch (e) {
   
      emit(state.clone(status: ProfileStatus.error));
    }
  }
}
