part of 'completed_comic_bloc.dart';

abstract class CompletedComicState extends Equatable {}

class CompletedComicLoadingState extends CompletedComicState {
  @override
  List<Object?> get props => [];
}

class CompletedComicLoadedState extends CompletedComicState {
  final List<Comic> CompletedComics;

  CompletedComicLoadedState(this.CompletedComics);

  @override
  List<Object?> get props => [CompletedComics];
}

class CompletedComicErrorState extends CompletedComicState {
  final String error;

  CompletedComicErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
