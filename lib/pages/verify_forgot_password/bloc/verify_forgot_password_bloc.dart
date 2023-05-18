import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/repository/authentication_repository.dart';

part 'verify_forgot_password_event.dart';
part 'verify_forgot_password_state.dart';

class VerifyForgotPasswordBloc
    extends Bloc<VerifyForgotPasswordEvent, VerifyForgotPasswordState> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  VerifyForgotPasswordBloc() : super(VerifyForgotPasswordInitial()) {
    on<SendOtpVerifyForgotPasswordEvent>(
        _handleSendOtpVerifyForgotPasswordEvent);
    // on<ResendEmailVerificationEvent>(_handleResendEmailVerificationEvent);
  }

  FutureOr<void> _handleSendOtpVerifyForgotPasswordEvent(
      SendOtpVerifyForgotPasswordEvent event,
      Emitter<VerifyForgotPasswordState> emit) async {
    emit(VerifyForgotPasswordLoading(email: event.email, otp: event.otp));
    try {
      final Map<String, dynamic> result = await _authenticationRepository
          .verifyForgotPassword(email: event.email, otp: event.otp);
      if (result['isSuccessed'] == true) {
        final successResult = result['result'];
        emit(VerifyForgotPasswordSuccess(message: successResult.message!));
      } else {
        final failureResult = result['result'];
        emit(VerifyForgotPasswordFailure(error: failureResult.message!));
      }
    } catch (e) {
      emit(VerifyForgotPasswordFailure(error: e.toString()));
    }
  }

  // Future<FutureOr<void>> _handleResendEmailVerificationEvent(
  //     ResendEmailVerificationEvent event, Emitter<OtpState> emit) async {
  //   emit(OtpInitial());
  //   try {
  //     final Map<String, dynamic> result =
  //         await _authenticationRepository.resendEmailVerification(
  //             email: event.email, password: event.password);
  //     if (result['isSuccessed'] == true) {
  //       final successResult = result['result'];
  //       emit(
  //           OtpResendEmailVerificationSuccess(message: successResult.message!));
  //     } else {
  //       final failureResult = result['result'];
  //       emit(OtpResendEmailVerificationFailure(error: failureResult.message!));
  //     }
  //   } catch (e) {
  //     emit(OtpResendEmailVerificationFailure(error: e.toString()));
  //   }
  // }
}
