import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hikicomic/data/models/error_auth.dart';
import 'package:hikicomic/data/models/response.dart';
import 'package:hikicomic/data/models/storage_item.dart';

import 'package:hikicomic/repository/authentication_repository.dart';
import 'package:hikicomic/utils/utils.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignInState()) {
    on<SignInLoadingEvent>(_handleSignInLoadingEvent);
    on<SignInButtonPressedEvent>(_handleSignInWithEmailAndPasswordEvent);
    on<SignInEmailChangedEvent>(_handleSignInEmailChangedEvent);
    on<SignInPasswordChangedEvent>(_handleSignInPasswordChangedEvent);
    on<SignInRememberMeChangedEvent>(_handleSignInRememberMeChangedEvent);
    on<SignInObscurePasswordChangedEvent>(
        _handleSignInObscurePasswordChangedEvent);
    on<SignInEmailValidatedEvent>(_handleSignInEmailValidatedEvent);
    on<SignInPasswordValidatedEvent>(_handleSignInPasswordValidatedEvent);
    on<SignInWithFacebookEvent>(_handleSignInWithFacebook);
    on<SignInWithGoogleEvent>(_handleSignInWithGoogle);
  }

  final AuthenticationRepository _authenticationRepository;
  // AuthenticationRepository();
  final Utils _utils = Utils();

  Future<void> _handleSignInLoadingEvent(
    SignInLoadingEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(SignInState(
        status: SignInStatus.loading,
        email: event.email!,
        password: event.password!));
  }

  Future<void> _handleSignInEmailChangedEvent(
    SignInEmailChangedEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _handleSignInPasswordChangedEvent(
    SignInPasswordChangedEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _handleSignInRememberMeChangedEvent(
    SignInRememberMeChangedEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(rememberMe: event.rememberMe));
  }

  Future<void> _handleSignInObscurePasswordChangedEvent(
    SignInObscurePasswordChangedEvent event,
    Emitter<SignInState> emit,
  ) async {
    emit(state.copyWith(isObscure: event.isObscure));
  }

  FutureOr<void> _handleSignInEmailValidatedEvent(
      SignInEmailValidatedEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(emailValidated: event.isValidated));
  }

  FutureOr<void> _handleSignInPasswordValidatedEvent(
      SignInPasswordValidatedEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(passwordValidated: event.isValidated));
  }

  Future<void> _handleSignInWithEmailAndPasswordEvent(
    SignInButtonPressedEvent event,
    Emitter<SignInState> emit,
  ) async {
    try {
      final Map<String, dynamic> loginResult =
          await _authenticationRepository.login(
        email: state.email,
        password: state.password,
        rememberMe: state.rememberMe,
      );

      if (loginResult['isSuccessed'] == true) {
        BaseResponse loginSuccessedResult = loginResult['result'];
        final StorageItem tokenItem =
            StorageItem(key: 'token', value: loginSuccessedResult.message!);
        final StorageItem isLoggedInItem =
            StorageItem(key: 'isLoggedIn', value: 'true');

        await _utils.persistToken(tokenItem);
        await _utils.persistToken(isLoggedInItem);
        // _utils.persistToken(userIdToken);
        // _utils.isLoggedIn(isLoggedInItem);
        _authenticationRepository.controller
            .add(AuthenticationStatus.authenticated);
// controller.add(AuthenticationStatus.authenticated);
        emit(state.copyWith(message: 'Success', status: SignInStatus.success));
      } else {
        ErrorResponse loginErrorResult = loginResult['result'];

        // Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(
            message: loginErrorResult.message,
            status: SignInStatus.failure,
            email: event.email,
            password: event.password));
        // }
        // );

        // print(state.message);
        // emit(state.copyWith(status: SignInStatus.loading));
      }
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(),
          status: SignInStatus.failure,
          email: event.email,
          password: event.password));
    }
  }

  Future<FutureOr<void>> _handleSignInWithFacebook(
      SignInWithFacebookEvent event, Emitter<SignInState> emit) async {
    AccessToken? accessToken;
    Map<String, dynamic>? userData;
    // _checkIfisLoggedIn() async {

    try {
      accessToken = await FacebookAuth.instance.accessToken;
      if (accessToken != null) {
        print("accesstokenfb: ${accessToken.toJson()}");
        userData = await FacebookAuth.instance.getUserData();
        //_accessToken = accessToken;
        print("tokens: ${accessToken.toJson()}");
      } else {
        final LoginResult result = await FacebookAuth.instance
            .login(permissions: ['email', 'public_profile']);

        if (result.status == LoginStatus.success) {
          accessToken = result.accessToken;
          print("accesstokenfb: ${result.accessToken!.token}");

          userData = await FacebookAuth.instance.getUserData();
          final StorageItem tokenItem = StorageItem(
              key: 'accessTokenFacebook', value: accessToken!.token);
          final StorageItem isLoggedInItem =
              StorageItem(key: 'isLoggedIn', value: 'true');

          await _utils.persistToken(tokenItem);
          await _utils.persistToken(isLoggedInItem);
          _authenticationRepository.controller
              .add(AuthenticationStatus.authenticated);
          emit(state.copyWith(
              message: 'Success',
              status: SignInStatus.success,
              accessTokenFacebook: accessToken,
              userData: userData));
        } else {
          print(result.status);
          print(result.message);
        }
      }
    } catch (e) {
      emit(state.copyWith(
        message: e.toString(),
        status: SignInStatus.failure,
      ));
    }
  }

  Future<FutureOr<void>> _handleSignInWithGoogle(
      SignInWithGoogleEvent event, Emitter<SignInState> emit) async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    // GoogleSignInAccount? currentUser=();
    try {
      String? accessToken;
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignIn
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
      final StorageItem isLoggedInItem =
          StorageItem(key: 'isLoggedIn', value: 'true');

      await _utils.persistToken(tokenItem);
      await _utils.persistToken(isLoggedInItem);
      _authenticationRepository.controller
          .add(AuthenticationStatus.authenticated);
      emit(state.copyWith(
          message: 'Success',
          status: SignInStatus.success,
          googleUser: googleUser,
          accessTokenGoogle: accessToken));
    } catch (error) {
      emit(state.copyWith(
        message: error.toString(),
        status: SignInStatus.failure,
      ));
    }
    // try {
    //   accessToken = await FacebookAuth.instance.accessToken;
    //   if (accessToken != null) {
    //     print(accessToken.toJson());
    //     userData = await FacebookAuth.instance.getUserData();
    //     //_accessToken = accessToken;
    //     print("tokens: ${accessToken.toJson()}");
    //   } else {
    //     final LoginResult result = await FacebookAuth.instance.login();

    //     if (result.status == LoginStatus.success) {
    //       accessToken = result.accessToken;

    //       userData = await FacebookAuth.instance.getUserData();
    //       final StorageItem tokenItem = StorageItem(
    //           key: 'accessTokenFacebook', value: accessToken!.token);
    //       final StorageItem isLoggedInItem =
    //           StorageItem(key: 'isLoggedIn', value: 'true');

    //       await _utils.persistToken(tokenItem);
    //       await _utils.persistToken(isLoggedInItem);
    //       _authenticationRepository.controller
    //           .add(AuthenticationStatus.authenticated);
    //       emit(state.copyWith(
    //           message: 'Success',
    //           status: SignInStatus.success,
    //           accessToken: accessToken,
    //           userData: userData));
    //     } else {
    //       print(result.status);
    //       print(result.message);
    //     }
    //   }
    // } catch (e) {
    //   emit(state.copyWith(
    //     message: e.toString(),
    //     status: SignInStatus.failure,
    //   ));
    // }
  }
}
