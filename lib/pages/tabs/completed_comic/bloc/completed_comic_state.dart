part of 'completed_comic_bloc.dart';

abstract class CompletedComicState extends Equatable {}

class CompletedComicLoadingState extends CompletedComicState {
  @override
  List<Object?> get props => [];
}

class CompletedComicLoadedState extends CompletedComicState {
  final List<Comic> completedComics;

  CompletedComicLoadedState(this.completedComics);

  @override
  List<Object?> get props => [completedComics];
}

class CompletedComicErrorState extends CompletedComicState {
  final String error;

  CompletedComicErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
