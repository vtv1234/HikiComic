part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();
}

class ForgotPasswordInitial extends ForgotPasswordState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ForgotPasswordLoading extends ForgotPasswordState {
  final String email;
  final bool isEmailValidated;

  ForgotPasswordLoading({required this.email, required this.isEmailValidated});
  @override
  // TODO: implement props
  List<Object> get props => [email, isEmailValidated];
}

class ForgotPasswordSuccess extends ForgotPasswordState {
  final String email;
  final String message;
  ForgotPasswordSuccess({required this.email, required this.message});

  @override
  // TODO: implement props
  List<Object> get props => [message];
}

class ForgotPasswordFailure extends ForgotPasswordState {
  final String error;

  ForgotPasswordFailure({required this.error});

  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class EmailChangedState extends ForgotPasswordState {
  final String email;

  EmailChangedState({required this.email});
  @override
  List<Object> get props => [email];
}
