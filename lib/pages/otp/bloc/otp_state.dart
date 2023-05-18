part of 'otp_bloc.dart';

abstract class OtpState extends Equatable {
  const OtpState();
}

class OtpInitial extends OtpState {
  @override
  List<Object?> get props => [];
}

class OtpLoading extends OtpState {
  final String email;
  final String password;
  final String otp;

  const OtpLoading(
      {required this.email, required this.password, required this.otp});

  @override
  List<Object?> get props => [email, password, otp];
}

class OtpSuccess extends OtpState {
  final String message;

  OtpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class OtpFailure extends OtpState {
  final String error;

  OtpFailure({required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [error];
}

class OtpResendEmailVerificationSuccess extends OtpState {
  final String message;

  OtpResendEmailVerificationSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}

class OtpResendEmailVerificationFailure extends OtpState {
  final String error;

  OtpResendEmailVerificationFailure({required this.error});
  @override
  List<Object?> get props => [error];
}
