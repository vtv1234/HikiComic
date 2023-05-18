part of 'ongoing_comic_bloc.dart';

abstract class OngoingComicState extends Equatable {
  @override
  List<Object?> get props => [];
}

class OngoingComicInitial extends OngoingComicState {}

class OngoingComicLoading extends OngoingComicState {}

class OngoingComicLoaded extends OngoingComicState {
  final List<Comic> ongoingComics;

  OngoingComicLoaded(this.ongoingComics);

  // @override
  // List<Object?> get props => [ongoingComics];
}

class OngoingComicError extends OngoingComicState {
  final String error;

  OngoingComicError(this.error);

  @override
  List<Object?> get props => [error];
}
