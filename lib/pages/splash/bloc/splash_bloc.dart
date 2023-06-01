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
      } else if (await utils.isLoggedIn() == "true" &&
          await utils.hasAccessTokenFacebook() == true) {
        final LoginResult result = await FacebookAuth.instance.login();

        if (result.status == LoginStatus.success) {
          AccessToken? accessToken = result.accessToken;
          print(result.accessToken!.token);

          Map<String, dynamic>? userData =
              await FacebookAuth.instance.getUserData();
          final StorageItem tokenItem = StorageItem(
              key: 'accessTokenFacebook', value: accessToken!.token);
          // final StorageItem isLoggedInItem =
          //     StorageItem(key: 'isLoggedIn', value: 'true');

          await utils.persistToken(tokenItem);
          // await utils.persistToken(isLoggedInItem);
          _authenticationRepository.controller
              .add(AuthenticationStatus.authenticated);
          final User user = User(
              id: userData['id'],
              userImageURL: userData['picture']['data']['url'],
              email: userData['email'],
              lastName: userData['name']);

          // final result = await _userRepository.getUser();
          // if (user != null) {
          _authenticationRepository.controller
              .add(AuthenticationStatus.authenticated);
          emit(SplashLoadedState(user: user));
          // print('user: ${result.ressultObj}');
          // print('get user');
          // }
          // emit(SplashLoadedState());
          // print(result);
        }
      } else if (await utils.isLoggedIn() == "true" &&
          await utils.hasAccessTokenGoogle() == true) {
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
        final StorageItem tokenItem =
            StorageItem(key: 'accessTokenGoogle', value: accessToken!);
        // final StorageItem isLoggedInItem =
        // StorageItem(key: 'isLoggedIn', value: 'true');

        await utils.persistToken(tokenItem);
        // await utils.persistToken(isLoggedInItem);
        _authenticationRepository.controller
            .add(AuthenticationStatus.authenticated);
      }

      emit(SplashLoadedState());

      // print('splash  error');
    } catch (e) {
      emit(SplashErrorState(e.toString()));
    }
  }
}
