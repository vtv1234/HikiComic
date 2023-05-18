part of 'following_comic_bloc.dart';

abstract class FollowingEvent extends Equatable {
  const FollowingEvent();

  @override
  List<Object> get props => [];
}

class LoadFollowingComicEvent extends FollowingEvent {}
