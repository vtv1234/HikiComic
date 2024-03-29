part of 'sign_in_bloc.dart';

enum SignInStatus {
  success,
  failure,
  loading,
}

class SignInState extends Equatable {
  const SignInState({
    this.message = '',
    this.status = SignInStatus.loading,
    this.email = '',
    this.password = '',
    this.rememberMe = true,
    this.isObscure = true,
    this.emailValidated = false,
    this.passwordValidated = false,
  });

  final String message;
  final SignInStatus status;
  final String email;
  final String password;
  final bool rememberMe;
  final bool isObscure;
  final bool emailValidated;
  final bool passwordValidated;

  SignInState copyWith(
      {String? email,
      String? password,
      SignInStatus? status,
      String? message,
      bool? rememberMe,
      bool? isObscure,
      bool? emailValidated,
      bool? passwordValidated}) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      message: message ?? this.message,
      rememberMe: rememberMe ?? this.rememberMe,
      isObscure: isObscure ?? this.isObscure,
      emailValidated: emailValidated ?? this.emailValidated,
      passwordValidated: passwordValidated ?? this.passwordValidated,
    );
  }

  @override
  List<Object?> get props => [
        message,
        status,
        email,
        password,
        rememberMe,
        isObscure,
        passwordValidated,
        emailValidated
      ];
}


// class CheckBoxRememberMeState extends Equatable {
  
  
//   List<Object?> get props => throw UnimplementedError();
// }
