part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class SendOtp extends OtpEvent {
  final String email;
  final String password;
  final String otp;

  const SendOtp(
      {required this.email, required this.password, required this.otp});
}

class ResendEmailVerificationEvent extends OtpEvent {
  final String email;
  final String password;

  const ResendEmailVerificationEvent(this.email, this.password);
}
