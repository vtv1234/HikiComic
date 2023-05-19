part of 'verify_forgot_password_bloc.dart';

abstract class VerifyForgotPasswordState extends Equatable {
  const VerifyForgotPasswordState();
}

class VerifyForgotPasswordInitial extends VerifyForgotPasswordState {
  @override
  List<Object?> get props => [];
}

class VerifyForgotPasswordLoading extends VerifyForgotPasswordState {
  final String email;
  final String otp;

  const VerifyForgotPasswordLoading({required this.email, required this.otp});

  @override
  List<Object?> get props => [email, otp];
}

class VerifyForgotPasswordSuccess extends VerifyForgotPasswordState {
  final String message;

  const VerifyForgotPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class VerifyForgotPasswordFailure extends VerifyForgotPasswordState {
  final String error;

  const VerifyForgotPasswordFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
