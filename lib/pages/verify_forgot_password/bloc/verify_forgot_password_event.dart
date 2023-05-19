part of 'verify_forgot_password_bloc.dart';

abstract class VerifyForgotPasswordEvent extends Equatable {
  const VerifyForgotPasswordEvent();
}

class SendOtpVerifyForgotPasswordEvent extends VerifyForgotPasswordEvent {
  final String email;
  final String otp;

  const SendOtpVerifyForgotPasswordEvent(this.email, this.otp);

  @override
  List<Object?> get props => [email, otp];
}
