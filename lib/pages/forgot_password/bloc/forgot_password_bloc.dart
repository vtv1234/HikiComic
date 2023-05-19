import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hikicomic/repository/authentication_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc()
      : super(const ForgotPasswordLoading(email: '', isEmailValidated: false)) {
    on<SendRequestForgotPasswordEvent>(_handleSendRequestForgotPassword);
    on<EmailChangedEvent>(_handleEmailChangedEvent);
    on<EmailValidateEvent>(_handleEmailValidateEvent);
  }
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();

  FutureOr<void> _handleEmailChangedEvent(
      EmailChangedEvent event, Emitter<ForgotPasswordState> emit) {
    emit(ForgotPasswordLoading(email: event.email, isEmailValidated: false));
  }

  Future<FutureOr<void>> _handleSendRequestForgotPassword(
      SendRequestForgotPasswordEvent event,
      Emitter<ForgotPasswordState> emit) async {
    // emit(ForgotPasswordLoading(email: event.email,isEmailValidated: event.is));
    try {
      final Map<String, dynamic> result =
          await _authenticationRepository.forgotPassword(email: event.email);
      if (result['isSuccessed'] == true) {
        final successResult = result['result'];
        emit(ForgotPasswordSuccess(
            email: event.email, message: successResult.message!));
      } else {
        final failureResult = result['result'];
        emit(ForgotPasswordFailure(error: failureResult.message!));
      }
    } catch (e) {
      emit(ForgotPasswordFailure(error: e.toString()));
    }
  }

  FutureOr<void> _handleEmailValidateEvent(
      EmailValidateEvent event, Emitter<ForgotPasswordState> emit) {
    emit(ForgotPasswordLoading(
        email: event.email, isEmailValidated: event.isValidated));
  }
}
