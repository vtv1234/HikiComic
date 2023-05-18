part of 'recent_comic_bloc.dart';

abstract class RecentEvent extends Equatable {
  const RecentEvent();

  @override
  List<Object> get props => [];
}

class LoadRecentComicEvent extends RecentEvent {}
