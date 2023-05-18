part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {}

// class SplashInitial extends SplashState {
//   @override
//   List<Object?> get props => [];
// }

class SplashLoadingState extends SplashState {
  SplashLoadingState();

  @override
  List<Object?> get props => [];
}

class SplashLoadedState extends SplashState {
  final User? user;

  SplashLoadedState({this.user});
  @override
  List<Object?> get props => [user];
}

class SplashErrorState extends SplashState {
  final String error;

  SplashErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
