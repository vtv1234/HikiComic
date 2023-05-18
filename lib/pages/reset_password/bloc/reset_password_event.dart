part of 'reset_password_bloc.dart';

// abstract class ResetPasswordEvent extends Equatable {
//   const ResetPasswordEvent();

//   @override
//   List<Object> get props => [];
// }

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();
}

class ResetPasswordLoadingEvent extends ResetPasswordEvent {
  final String? email;
  final String? password;
  final String? confirmPassword;

  const ResetPasswordLoadingEvent(
      {required this.email,
      required this.password,
      required this.confirmPassword});
  @override
  List<Object?> get props => [email, password, confirmPassword];
}

class ResetPasswordButtonPressedEvent extends ResetPasswordEvent {
  final String email;
  final String password;
  final String confirmPassword;
  const ResetPasswordButtonPressedEvent(
      {required this.email,
      required this.password,
      required this.confirmPassword});

  @override
  List<Object?> get props => [email, password, confirmPassword];
}

class ResetPasswordEmailChangedEvent extends ResetPasswordEvent {
  const ResetPasswordEmailChangedEvent({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class ResetPasswordPasswordChangedEvent extends ResetPasswordEvent {
  const ResetPasswordPasswordChangedEvent({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class ResetPasswordConfirmPasswordChangedEvent extends ResetPasswordEvent {
  const ResetPasswordConfirmPasswordChangedEvent(
      {required this.confirmPassword});

  final String confirmPassword;

  @override
  List<Object> get props => [confirmPassword];
}

class ResetPasswordObscurePasswordChangedEvent extends ResetPasswordEvent {
  final bool isObscure;

  const ResetPasswordObscurePasswordChangedEvent({required this.isObscure});

  @override
  List<Object?> get props => [isObscure];
}

class ResetPasswordObscureConfirmPasswordChangedEvent
    extends ResetPasswordEvent {
  final bool isObscure;

  const ResetPasswordObscureConfirmPasswordChangedEvent(
      {required this.isObscure});

  @override
  List<Object?> get props => [isObscure];
}

class ResetPasswordPasswordValidatedEvent extends ResetPasswordEvent {
  final bool isValidated;

  const ResetPasswordPasswordValidatedEvent({required this.isValidated});

  @override
  List<Object?> get props => [isValidated];
}

class ResetPasswordConfirmPasswordValidatedEvent extends ResetPasswordEvent {
  final bool isValidated;

  const ResetPasswordConfirmPasswordValidatedEvent({required this.isValidated});

  @override
  List<Object?> get props => [isValidated];
}

class ResetPasswordEmailValidatedEvent extends ResetPasswordEvent {
  final bool isValidated;

  const ResetPasswordEmailValidatedEvent({required this.isValidated});

  @override
  List<Object?> get props => [isValidated];
}
