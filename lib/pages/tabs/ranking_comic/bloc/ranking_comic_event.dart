part of 'ranking_comic_bloc.dart';

abstract class RankingComicEvent extends Equatable {
  const RankingComicEvent();
}

class LoadRankingComicEvent extends RankingComicEvent {
  @override
  List<Object?> get props => [];
}
