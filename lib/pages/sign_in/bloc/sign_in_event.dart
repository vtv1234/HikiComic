part of 'sign_in_bloc.dart';

abstract class SignInEvent extends Equatable {
  const SignInEvent();
}

class SignInLoadingEvent extends SignInEvent {
  final String? email;
  final String? password;

  const SignInLoadingEvent({required this.email, required this.password});
  @override
  List<Object?> get props => [email, password];
}

class SignInButtonPressedEvent extends SignInEvent {
  final String email;
  final String password;
  const SignInButtonPressedEvent({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignInEmailChangedEvent extends SignInEvent {
  const SignInEmailChangedEvent({required this.email});

  final String email;

  @override
  List<Object> get props => [email];
}

class SignInPasswordChangedEvent extends SignInEvent {
  const SignInPasswordChangedEvent({required this.password});

  final String password;

  @override
  List<Object> get props => [password];
}

class SignInRememberMeChangedEvent extends SignInEvent {
  const SignInRememberMeChangedEvent({required this.rememberMe});

  final bool rememberMe;

  @override
  List<Object> get props => [rememberMe];
}

class SignInObscurePasswordChangedEvent extends SignInEvent {
  final bool isObscure;

  const SignInObscurePasswordChangedEvent({required this.isObscure});

  @override
  List<Object?> get props => [isObscure];
}

class SignInPasswordValidatedEvent extends SignInEvent {
  final bool isValidated;

  const SignInPasswordValidatedEvent({required this.isValidated});

  @override
  List<Object?> get props => [isValidated];
}

class SignInEmailValidatedEvent extends SignInEvent {
  final bool isValidated;

  const SignInEmailValidatedEvent({required this.isValidated});

  @override
  List<Object?> get props => [isValidated];
}

class SignInWithFacebookEvent extends SignInEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SignInWithGoogleEvent extends SignInEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
