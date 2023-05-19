part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  List<Object?> get props => [];
}

class ForgotPasswordLoading extends ForgotPasswordState {
  final String email;
  final bool isEmailValidated;

  const ForgotPasswordLoading(
      {required this.email, required this.isEmailValidated});
  @override
  List<Object> get props => [email, isEmailValidated];
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String email;
  final String message;
  const ForgotPasswordSuccess({required this.email, required this.message});

  @override
  List<Object> get props => [message];
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String error;

  const ForgotPasswordFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class EmailChangedState extends ForgotPasswordState {
  final String email;

  const EmailChangedState({required this.email});
  @override
  List<Object> get props => [email];
}
