import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hikicomic/repository/authentication_repository.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final AuthenticationRepository _authenticationRepository =
      AuthenticationRepository();
  OtpBloc() : super(OtpInitial()) {
    on<SendOtp>(_handleSendOtpEvent);
    on<ResendEmailVerificationEvent>(_handleResendEmailVerificationEvent);
  }

  FutureOr<void> _handleSendOtpEvent(
      SendOtp event, Emitter<OtpState> emit) async {
    try {
      final Map<String, dynamic> result =
          await _authenticationRepository.verifyEmail(
              email: event.email, password: event.password, otp: event.otp);
      if (result['isSuccessed'] == true) {
        final successResult = result['result'];
        emit(OtpSuccess(message: successResult.message!));
      } else {
        final failureResult = result['result'];
        emit(OtpFailure(error: failureResult.message!));
      }
    } catch (e) {
      emit(OtpFailure(error: e.toString()));
    }
  }

  Future<FutureOr<void>> _handleResendEmailVerificationEvent(
      ResendEmailVerificationEvent event, Emitter<OtpState> emit) async {
    emit(OtpInitial());
    try {
      final Map<String, dynamic> result =
          await _authenticationRepository.resendEmailVerification(
              email: event.email, password: event.password);
      if (result['isSuccessed'] == true) {
        final successResult = result['result'];
        emit(
            OtpResendEmailVerificationSuccess(message: successResult.message!));
      } else {
        final failureResult = result['result'];
        emit(OtpResendEmailVerificationFailure(error: failureResult.message!));
      }
    } catch (e) {
      emit(OtpResendEmailVerificationFailure(error: e.toString()));
    }
  }
}
