part of 'recent_comic_bloc.dart';

abstract class RecentComicState extends Equatable {
  const RecentComicState();

  @override
  List<Object> get props => [];
}

class RecentComicInitial extends RecentComicState {}

class RecentComicLoading extends RecentComicState {}

class RecentComicLoaded extends RecentComicState {
  final List<HistoryComic> recentComic;

  const RecentComicLoaded(this.recentComic);
  @override
  List<Object> get props => [recentComic];
}

class RecentComicError extends RecentComicState {
  final String error;

  RecentComicError(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
