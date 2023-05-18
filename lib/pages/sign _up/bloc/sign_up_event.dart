part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();
}

class SignUpLoadingEvent extends SignUpEvent {
  final String? email;
  final String? password;
  final String? confirmPassword;

  const SignUpLoadingEvent(
      {required this.email,
      required this.password,
      required this.confirmPassword});
  @override
  List<Object?> get props => [email, password, confirmPassword];
}

class SignUpButtonPressedEvent extends SignUpEvent {
  final String email;
  final String password;
  final String confirmPassword;
  const SignUpButtonPressedEvent(
      {required this.email,
      required this.password,
      required this.confirmPassword});

  @override
  List<Object?> get props => [email, password, confirmPassword];
}

class SignUpEmailChangedEvent extends SignUpEvent {
  const SignUpEmailChangedEvent({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class SignUpPasswordChangedEvent extends SignUpEvent {
  const SignUpPasswordChangedEvent({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class SignUpConfirmPasswordChangedEvent extends SignUpEvent {
  const SignUpConfirmPasswordChangedEvent({required this.confirmPassword});

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class SignUpObscurePasswordChangedEvent extends SignUpEvent {
  final bool isObscure;

  const SignUpObscurePasswordChangedEvent({required this.isObscure});

  @override
  List<Object?> get props => [isObscure];
}

class SignUpObscureConfirmPasswordChangedEvent extends SignUpEvent {
  final bool isObscure;

  const SignUpObscureConfirmPasswordChangedEvent({required this.isObscure});

  @override
  List<Object?> get props => [isObscure];
}

class SignUpPasswordValidatedEvent extends SignUpEvent {
  final bool isValidated;

  const SignUpPasswordValidatedEvent({required this.isValidated});

  @override
  List<Object?> get props => [isValidated];
}

class SignUpConfirmPasswordValidatedEvent extends SignUpEvent {
  final bool isValidated;

  const SignUpConfirmPasswordValidatedEvent({required this.isValidated});

  @override
  List<Object?> get props => [isValidated];
}

class SignUpEmailValidatedEvent extends SignUpEvent {
  final bool isValidated;

  const SignUpEmailValidatedEvent({required this.isValidated});

  @override
  List<Object?> get props => [isValidated];
}
