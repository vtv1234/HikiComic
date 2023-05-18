import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hikicomic/data/models/user.dart';
import 'package:hikicomic/pages/authentication/authentication.dart';
import 'package:hikicomic/repository/authentication_repository.dart';
import 'package:hikicomic/repository/user_repository.dart';
import 'package:hikicomic/utils/utils.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc({required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(SplashLoadingState()) {
    on<GetUserEvent>(_handleGetUserEvent);
  }
  final UserRepository _userRepository = UserRepository();
  final AuthenticationRepository _authenticationRepository;
  final utils = Utils();
  Future<void> _handleGetUserEvent(
      GetUserEvent event, Emitter<SplashState> emit) async {
    try {
      // utils.deleteAllSecureData();

      if (await utils.isLoggedIn() == "true" &&
          await utils.hasToken() == true) {
        final result = await _userRepository.getUser();
        if (result != null) {
          _authenticationRepository.controller
              .add(AuthenticationStatus.authenticated);
          emit(SplashLoadedState(user: result.ressultObj));
          // print('user: ${result.ressultObj}');
          // print('get user');
        }
        emit(SplashLoadedState());
        // print(result);
      }
      emit(SplashLoadedState());
      // print('splash  error');
    } catch (e) {
      emit(SplashErrorState(e.toString()));
    }
  }
}
