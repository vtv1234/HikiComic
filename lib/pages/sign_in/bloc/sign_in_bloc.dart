import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
}
