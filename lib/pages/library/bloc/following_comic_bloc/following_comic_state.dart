part of 'following_comic_bloc.dart';

abstract class FollowingComicState extends Equatable {
  const FollowingComicState();

  @override
  List<Object> get props => [];
}

class FollowingComicInitial extends FollowingComicState {}

class FollowingComicLoading extends FollowingComicState {}

class FollowingComicLoaded extends FollowingComicState {
  final List<Comic> followingComic;

  const FollowingComicLoaded(this.followingComic);
  @override
  List<Object> get props => [followingComic];
}

class FollowingComicError extends FollowingComicState {
  final String error;

  FollowingComicError(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}
