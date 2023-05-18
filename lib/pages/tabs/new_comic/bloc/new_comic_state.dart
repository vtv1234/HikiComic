part of 'new_comic_bloc.dart';

abstract class NewComicState extends Equatable {}

class NewComicLoadingState extends NewComicState {
  @override
  List<Object?> get props => [];
}

class NewComicLoadedState extends NewComicState {
  final List<Comic> newComics;

  NewComicLoadedState(this.newComics);

  @override
  List<Object?> get props => [newComics];
}

class NewComicErrorState extends NewComicState {
  final String error;

  NewComicErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
