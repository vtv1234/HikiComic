import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/error_auth.dart';
import 'package:hikicomic/data/models/response.dart';
import 'package:hikicomic/repository/account_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(const ResetPasswordState()) {
    on<ResetPasswordLoadingEvent>(_handleResetPasswordLoadingEvent);
    on<ResetPasswordButtonPressedEvent>(_handleResetPasswordEvent);
    on<ResetPasswordEmailChangedEvent>(_handleResetPasswordEmailChangedEvent);
    on<ResetPasswordPasswordChangedEvent>(
        _handleResetPasswordPasswordChangedEvent);
    on<ResetPasswordConfirmPasswordChangedEvent>(
        _handleResetPasswordConfirmPasswordChangedEvent);
    // on<ResetPasswordRememberMeChangedEvent>(_handleResetPasswordRememberMeChangedEvent);
    on<ResetPasswordObscurePasswordChangedEvent>(
        _handleResetPasswordObscurePasswordChangedEvent);
    on<ResetPasswordObscureConfirmPasswordChangedEvent>(
        _handleResetPasswordObscureConfirmPasswordChangedEvent);
    on<ResetPasswordEmailValidatedEvent>(
        _handleResetPasswordEmailValidatedEvent);
    on<ResetPasswordPasswordValidatedEvent>(
        _handleResetPasswordPasswordValidatedEvent);
    on<ResetPasswordConfirmPasswordValidatedEvent>(
        _handleResetPasswordConfirmPasswordValidatedEvent);
  }

  final AccountRepository _accountRepository = AccountRepository();
  // AuthenticationRepository();

  Future<void> _handleResetPasswordLoadingEvent(
    ResetPasswordLoadingEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(ResetPasswordState(
        status: ResetPasswordStatus.loading,
        email: event.email!,
        password: event.password!,
        confirmPassword: event.confirmPassword!));
  }

  Future<void> _handleResetPasswordEmailChangedEvent(
    ResetPasswordEmailChangedEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(email: event.email));
  }

  Future<void> _handleResetPasswordPasswordChangedEvent(
    ResetPasswordPasswordChangedEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _handleResetPasswordConfirmPasswordChangedEvent(
    ResetPasswordConfirmPasswordChangedEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(confirmPassword: event.confirmPassword));
  }

  // Future<void> _handleResetPasswordRememberMeChangedEvent(
  //   ResetPasswordRememberMeChangedEvent event,
  //   Emitter<ResetPasswordState> emit,
  // ) async {
  //   emit(state.copyWith(rememberMe: event.rememberMe));
  // }

  Future<void> _handleResetPasswordObscurePasswordChangedEvent(
    ResetPasswordObscurePasswordChangedEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(isPasswordObscure: event.isObscure));
  }

  Future<void> _handleResetPasswordObscureConfirmPasswordChangedEvent(
    ResetPasswordObscureConfirmPasswordChangedEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(isConfirmPasswordObscure: event.isObscure));
  }

  FutureOr<void> _handleResetPasswordEmailValidatedEvent(
      ResetPasswordEmailValidatedEvent event,
      Emitter<ResetPasswordState> emit) async {
    emit(state.copyWith(emailValidated: event.isValidated));
  }

  FutureOr<void> _handleResetPasswordPasswordValidatedEvent(
      ResetPasswordPasswordValidatedEvent event,
      Emitter<ResetPasswordState> emit) async {
    emit(state.copyWith(passwordValidated: event.isValidated));
  }

  FutureOr<void> _handleResetPasswordConfirmPasswordValidatedEvent(
      ResetPasswordConfirmPasswordValidatedEvent event,
      Emitter<ResetPasswordState> emit) async {
    emit(state.copyWith(confirmPasswordValidated: event.isValidated));
  }

  Future<void> _handleResetPasswordEvent(
    ResetPasswordButtonPressedEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    try {
      final Map<String, dynamic> registerResult =
          await _accountRepository.resetPassword(
        email: event.email,
        newPassword: event.password,
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
            status: ResetPasswordStatus.success));
      } else {
        ErrorResponse loginErrorResult = registerResult['result'];

        // Future.delayed(const Duration(seconds: 1), () {
        emit(state.copyWith(
            message: loginErrorResult.message,
            status: ResetPasswordStatus.failure,
            email: event.email,
            password: event.password,
            confirmPassword: event.confirmPassword));
        // }
        // );

        // print(state.message);
        // emit(state.copyWith(status: ResetPasswordStatus.loading));
      }
    } catch (e) {
      emit(state.copyWith(
          message: e.toString(),
          status: ResetPasswordStatus.failure,
          email: event.email,
          password: event.password,
          confirmPassword: event.confirmPassword));
    }
  }
}
