part of 'verify_forgot_password_bloc.dart';

abstract class VerifyForgotPasswordEvent extends Equatable {
  const VerifyForgotPasswordEvent();
}

class SendOtpVerifyForgotPasswordEvent extends VerifyForgotPasswordEvent {
  final String email;
  final String otp;

  SendOtpVerifyForgotPasswordEvent(this.email, this.otp);

  @override
  // TODO: implement props
  List<Object?> get props => [email, otp];
}
// class LoadingVerifyForgotPasswordEvent extends VerifyForgotPasswordEvent{
//   final String email;
//   final String otp;

//   LoadingVerifyForgotPasswordEvent(this.email, this.otp);
  
//   @override
//   // TODO: implement props
//   List<Object?> get props => [email,otp];
// }
