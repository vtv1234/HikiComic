import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hikicomic/data/models/user.dart';
import 'package:hikicomic/repository/authentication_repository.dart';
import 'package:hikicomic/repository/user_repository.dart';
import 'package:hikicomic/utils/utils.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required AuthenticationRepository authenticationRepository,
    required UserRepository userRepository,
  })  : _authenticationRepository = authenticationRepository,
        _userRepository = userRepository,
        super(const AuthenticationState.unknown()) {
    on<_AuthenticationStatusChanged>(_onAuthenticationStatusChanged);
    on<AuthenticationLogoutRequested>(_onAuthenticationLogoutRequested);
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(_AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final UserRepository _userRepository;
  late StreamSubscription<AuthenticationStatus>
      _authenticationStatusSubscription;
  final Utils utils = Utils();

  @override
  Future<void> close() {
    _authenticationStatusSubscription.cancel();
    return super.close();
  }

  Future<void> _onAuthenticationStatusChanged(
    _AuthenticationStatusChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return emit(const AuthenticationState.unauthenticated());
      case AuthenticationStatus.authenticated:
        final user = await _tryGetUser();
        return emit(
          user != null
              ? AuthenticationState.authenticated(user)
              : const AuthenticationState.unauthenticated(),
        );
      case AuthenticationStatus.unknown:
        return emit(const AuthenticationState.unknown());
    }
  }

  void _onAuthenticationLogoutRequested(
    AuthenticationLogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) {
    _authenticationRepository.logOut();
  }

  Future<User?> _tryGetUser() async {
    try {
      if (await utils.isLoggedIn() == "true" &&
          await utils.hasToken() == true) {
        final user = await _userRepository.getUser();
        return user!.ressultObj;

        // print(result);
      } else if (await utils.isLoggedIn() == "true" &&
          await utils.hasAccessTokenFacebook() == true) {
        Map<String, dynamic>? userData =
            await FacebookAuth.instance.getUserData();
        final User user = User(
            id: userData['id'],
            userImageURL: userData['picture']['data']['url'],
            email: userData['email'],
            lastName: userData['name']);
        return user;
      } else if (await utils.isLoggedIn() == "true" &&
          await utils.hasAccessTokenGoogle() == true) {
        GoogleSignIn googleSignIn = GoogleSignIn();
        final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
        // .then((value) => value!.authentication.then((googleKey) {
        //       //accessToken = googleKey.accessToken;
        //       print(googleKey.accessToken);
        //       print(googleKey.idToken);
        //     }));
        final User user = User(
            id: googleUser!.id,
            userImageURL: googleUser.photoUrl ?? "default.png",
            email: googleUser.email,
            lastName: googleUser.displayName);
        return user;
      }
      return null;
    } catch (_) {
      return null;
    }
  }
}
