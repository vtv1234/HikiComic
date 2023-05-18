part of 'ranking_comic_bloc.dart';

abstract class RankingComicState extends Equatable {}

class RankingComicLoadingState extends RankingComicState {
  @override
  List<Object?> get props => [];
}

class RankingComicLoadedState extends RankingComicState {
  final List<Comic> rankingComics;

  RankingComicLoadedState(this.rankingComics);

  @override
  List<Object?> get props => [rankingComics];
}

class RankingComicErrorState extends RankingComicState {
  final String error;

  RankingComicErrorState(this.error);

  @override
  List<Object?> get props => [error];
}
