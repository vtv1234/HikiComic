part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendRequestForgotPasswordEvent extends ForgotPasswordEvent {
  final String email;

  SendRequestForgotPasswordEvent({required this.email});
  @override
  List<Object> get props => [email];
}

class EmailChangedEvent extends ForgotPasswordEvent {
  final String email;

  EmailChangedEvent(this.email);
  @override
  List<Object> get props => [email];
}

class EmailValidateEvent extends ForgotPasswordEvent {
  final String email;
  final bool isValidated;

  EmailValidateEvent({required this.email, required this.isValidated});
  @override
  // TODO: implement props
  List<Object> get props => [isValidated];
}
