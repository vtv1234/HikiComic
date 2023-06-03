import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hikicomic/data/models/storage_item.dart';
import 'package:hikicomic/data/models/user.dart';

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

      if (await utils.methodLogin() != "" && await utils.hasToken() == true) {
        final result = await _userRepository.getUser();
        if (result != null) {
          _authenticationRepository.controller
              .add(AuthenticationStatus.authenticated);
          emit(SplashLoadedState(user: result.resultObj));
          // print('user: ${result.resultObj}');
          // print('get user');
        }
        emit(SplashLoadedState());
        // print(result);
      } else if (await utils.methodLogin() == "facebook" &&
          await utils.hasToken() == true &&
          await utils.hasAccessTokenFacebook()) {
        final LoginResult loginResult = await FacebookAuth.instance.login();

        if (loginResult.status == LoginStatus.success) {
          AccessToken? accessToken = loginResult.accessToken;
          print(loginResult.accessToken!.token);

          Map<String, dynamic>? userData =
              await FacebookAuth.instance.getUserData();
          final StorageItem accessTokenFacebookItem = StorageItem(
              key: 'accessTokenFacebook', value: accessToken!.token);
          // final StorageItem methodLoginItem =
          //     StorageItem(key: 'methodLogin', value: 'true');

          await utils.persistToken(accessTokenFacebookItem);
          final result = await _userRepository.getUser();
          if (result != null) {
            _authenticationRepository.controller
                .add(AuthenticationStatus.authenticated);
            emit(SplashLoadedState(user: result.resultObj));
            // print('user: ${result.resultObj}');
            // print('get user');
          }
          // await utils.persistToken(methodLoginItem);
          // _authenticationRepository.controller
          //     .add(AuthenticationStatus.authenticated);

          // emit(SplashLoadedState(user: result.resultObj));
          // print('user: ${result.resultObj}');
          // print('get user');
          // }
          // emit(SplashLoadedState());
          // print(result);
        }
      } else if (await utils.methodLogin() == "google" &&
          await utils.hasToken() == true &&
          await utils.hasAccessTokenGoogle()) {
        // try {
        String? accessToken;
        GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleUser = await googleSignIn
            .signIn()
            .then((value) => value!.authentication.then((googleKey) {
                  accessToken = googleKey.accessToken;

                  print("accesstokengg: ${googleKey.accessToken}");
                  print(googleKey.idToken);
                }));
        // await _googleSignIn.signIn();
        print("googleUser: $googleUser");
        final StorageItem accessTokenGoogleItem =
            StorageItem(key: 'accessTokenGoogle', value: accessToken!);
        // final StorageItem methodLoginItem =
        //     StorageItem(key: 'methodLogin', value: 'true');

        await utils.persistToken(accessTokenGoogleItem);
        final result = await _userRepository.getUser();
        if (result != null) {
          _authenticationRepository.controller
              .add(AuthenticationStatus.authenticated);
          emit(SplashLoadedState(user: result.resultObj));
          // print('user: ${result.resultObj}');
          // print('get user');
        }
      }

      emit(SplashLoadedState());

      // print('splash  error');
    } catch (e) {
      emit(SplashErrorState(e.toString()));
    }
  }
}
