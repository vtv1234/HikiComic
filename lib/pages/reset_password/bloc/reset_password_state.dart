part of 'reset_password_bloc.dart';

// abstract class ResetPasswordState extends Equatable {
//   const ResetPasswordState();

//   @override
//   List<Object> get props => [];
// }

// class ResetPasswordInitial extends ResetPasswordState {}

// part of 'sign_up_bloc.dart';

enum ResetPasswordStatus {
  success,
  failure,
  loading,
}

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    // this.rememberMe = false,
    this.message = '',
    this.status = ResetPasswordStatus.loading,
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isPasswordObscure = true,
    this.isConfirmPasswordObscure = true,
    this.emailValidated = false,
    this.passwordValidated = false,
    this.confirmPasswordValidated = false,
  });

  final String message;
  final ResetPasswordStatus status;
  final String email;
  final String password;
  final String confirmPassword;
  final bool isPasswordObscure;
  // final bool rememberMe;
  final bool isConfirmPasswordObscure;
  final bool emailValidated;
  final bool passwordValidated;
  final bool confirmPasswordValidated;

  // SignUpState copyWith(
  //     {String? email,
  //     String? password,
  //     SignUpStatus? status,
  //     String? message,
  //     bool? rememberMe,
  //     bool? isObscure,
  //     bool? emailValidated,
  //     bool? passwordValidated}) {
  //   return SignUpState(
  //     email: email ?? this.email,
  //     password: password ?? this.password,
  //     password: password ?? this.password,
  //     status: status ?? this.status,
  //     message: message ?? this.message,
  //     // rememberMe: rememberMe ?? this.rememberMe,
  //     isObscure: isObscure ?? this.isObscure,
  //     emailValidated: emailValidated ?? this.emailValidated,
  //     passwordValidated: passwordValidated ?? this.passwordValidated,
  //   );
  // }

  @override
  List<Object?> get props {
    return [
      message,
      status,
      email,
      password,
      confirmPassword,
      isPasswordObscure,
      isConfirmPasswordObscure,
      emailValidated,
      passwordValidated,
      confirmPasswordValidated,
    ];
  }

  ResetPasswordState copyWith({
    String? message,
    ResetPasswordStatus? status,
    String? email,
    String? password,
    String? confirmPassword,
    bool? isPasswordObscure,
    bool? isConfirmPasswordObscure,
    bool? emailValidated,
    bool? passwordValidated,
    bool? confirmPasswordValidated,
  }) {
    return ResetPasswordState(
      message: message ?? this.message,
      status: status ?? this.status,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      isConfirmPasswordObscure:
          isConfirmPasswordObscure ?? this.isConfirmPasswordObscure,
      emailValidated: emailValidated ?? this.emailValidated,
      passwordValidated: passwordValidated ?? this.passwordValidated,
      confirmPasswordValidated:
          confirmPasswordValidated ?? this.confirmPasswordValidated,
    );
  }

  // Map<String, dynamic> toMap() {
  //   return <String, dynamic>{
  //     'message': message,
  //     'status': status.toMap(),
  //     'email': email,
  //     'password': password,
  //     'confirmPassword': confirmPassword,
  //     'isObscure': isObscure,
  //     'emailValidated': emailValidated,
  //     'passwordValidated': passwordValidated,
  //     'confirmPasswordValidated': confirmPasswordValidated,
  //   };
  // }

  // factory SignUpState.fromMap(Map<String, dynamic> map) {
  //   return SignUpState(
  //     message: map['message'] as String,
  //     status: SignUpStatus.fromMap(map['status'] as Map<String,dynamic>),
  //     email: map['email'] as String,
  //     password: map['password'] as String,
  //     confirmPassword: map['confirmPassword'] as String,
  //     isObscure: map['isObscure'] as bool,
  //     emailValidated: map['emailValidated'] as bool,
  //     passwordValidated: map['passwordValidated'] as bool,
  //     confirmPasswordValidated: map['confirmPasswordValidated'] as bool,
  //   );
  // }

  // String toJson() => json.encode(toMap());

  // factory SignUpState.fromJson(String source) => SignUpState.fromMap(json.decode(source) as Map<String, dynamic>);

  // @override
  // bool get stringify => true;
}


// class CheckBoxRememberMeState extends Equatable {
  
  
//   List<Object?> get props => throw UnimplementedError();
// }
