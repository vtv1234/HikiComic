part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendRequestForgotPasswordEvent extends ForgotPasswordEvent {
  final String email;

  const SendRequestForgotPasswordEvent({required this.email});
  @override
  List<Object> get props => [email];
}

class EmailChangedEvent extends ForgotPasswordEvent {
  final String email;

  const EmailChangedEvent(this.email);
  @override
  List<Object> get props => [email];
}

class EmailValidateEvent extends ForgotPasswordEvent {
  final String email;
  final bool isValidated;

  const EmailValidateEvent({required this.email, required this.isValidated});
  @override
  List<Object> get props => [isValidated];
}
