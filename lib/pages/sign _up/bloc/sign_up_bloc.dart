import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/error_auth.dart';
import 'package:hikicomic/data/models/response.dart';
import 'package:hikicomic/repository/authentication_repository.dart';
import 'package:hikicomic/utils/utils.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const SignUpState()) {
    on<SignUpLoadingEvent>(_handleSignUpLoadingEvent);
    on<SignUpButtonPressedEvent>(_handleSignUpEvent);
    on<SignUpEmailChangedEvent>(_handleSignUpEmailChangedEvent);
    on<SignUpPasswordChangedEvent>(_handleSignUpPasswordChangedEvent);
    on<SignUpConfirmPasswordChangedEvent>(
        _handleSignUpConfirmPasswordChangedEvent);
    // on<SignUpRememberMeChangedEvent>(_handleSignUpRememberMeChangedEvent);
    on<SignUpObscurePasswordChangedEvent>(
        _handleSignUpObscurePasswordChangedEvent);
    on<SignUpObscureConfirmPasswordChangedEvent>(
        _handleSignUpObscureConfirmPasswordChangedEvent);
    on<SignUpEmailValidatedEvent>(_handleSignUpEmailValidatedEvent);
    on<SignUpPasswordValidatedEvent>(_handleSignUpPasswordValidatedEvent);
    on<SignUpConfirmPasswordValidatedEvent>(
        _handleSignUpConfirmPasswordValidatedEvent);
  }

  final AuthenticationRepository _authenticationRepository;
  // AuthenticationRepository();
  final Utils _utils = Utils();

  Future<void> _handleSignUpLoadingEvent(
    SignUpLoadingEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(SignUpState(
        status: SignUpStatus.loading,
        email: event.email!,
        password: event.password!,
        confirmPassword: event.confirmPassword!));
  }

  Future<void> _handleSignUpEmailChangedEvent(
    SignUpEmailChangedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _handleSignUpPasswordChangedEvent(
    SignUpPasswordChangedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _handleSignUpConfirmPasswordChangedEvent(
    SignUpConfirmPasswordChangedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  // Future<void> _handleSignUpRememberMeChangedEvent(
  //   SignUpRememberMeChangedEvent event,
  //   Emitter<SignUpState> emit,
  // ) async {
  //   emit(state.copyWith(rememberMe: event.rememberMe));
  // }

  Future<void> _handleSignUpObscurePasswordChangedEvent(
    SignUpObscurePasswordChangedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(isPasswordObscure: event.isObscure));
  }

  Future<void> _handleSignUpObscureConfirmPasswordChangedEvent(
    SignUpObscureConfirmPasswordChangedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    emit(state.copyWith(isConfirmPasswordObscure: event.isObscure));
  }

  FutureOr<void> _handleSignUpEmailValidatedEvent(
      SignUpEmailValidatedEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(emailValidated: event.isValidated));
  }

  FutureOr<void> _handleSignUpPasswordValidatedEvent(
      SignUpPasswordValidatedEvent event, Emitter<SignUpState> emit) async {
    emit(state.copyWith(passwordValidated: event.isValidated));
  }

  FutureOr<void> _handleSignUpConfirmPasswordValidatedEvent(
      SignUpConfirmPasswordValidatedEvent event,
      Emitter<SignUpState> emit) async {
    emit(state.copyWith(confirmPasswordValidated: event.isValidated));
  }

  Future<void> _handleSignUpEvent(
    SignUpButtonPressedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    try {
      final Map<String, dynamic> registerResult =
          await _authenticationRepository.register(
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );

      if (registerResult['isSuccessed'] == true) {
        BaseResponse regiseterSuccessedResult = registerResult['result'];
        // final StorageItem tokenItem =
        //     StorageItem(key: 'token', value: loginSuccessedResult.message!);
        // final StorageItem isLoggedInItem =
        //     StorageItem(key: 'isLoggedIn', value: 'true');

        // await _utils.persistToken(tokenItem);
        // await _utils.persistToken(isLoggedInItem);
        // _utils.persistToken(userIdToken);
        // _utils.isLoggedIn(isLoggedInItem);
        // _authenticationRepository.controller
        //     .add(AuthenticationStatus.authenticated);
// controller.add(AuthenticationStatus.authenticated);
        emit(state.copyWith(
            message: regiseterSuccessedResult.message,
            email: event.email,
            password: event.password,
            status: SignUpStatus.success));
      } else {
        ErrorResponse loginErrorResult = registerResult['result'];

        // Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(
            message: loginErrorResult.message,
            status: SignUpStatus.failure,
            email: event.email,
            password: event.password,
            confirmPassword: event.confirmPassword));
        // }
        // );

        // print(state.message);
        // emit(state.copyWith(status: SignUpStatus.loading));
      }
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(),
          status: SignUpStatus.failure,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword));
    }
  }
}
