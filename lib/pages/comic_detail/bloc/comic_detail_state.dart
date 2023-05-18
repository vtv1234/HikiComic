part of 'comic_detail_bloc.dart';

abstract class ComicDetailState extends Equatable {
  const ComicDetailState();

  // @override
  // List<Object> get props => [];
}

class LoadingComicDetailState extends ComicDetailState {
  @override
  List<Object?> get props => [];
}

class LoadedComicDetailState extends ComicDetailState {
  final ComicDetail comicDetail;
  final List<Chapter> chapters;

  const LoadedComicDetailState(this.comicDetail, this.chapters);

  @override
  List<Object?> get props => [comicDetail, chapters];
}

class ErrorComicDetailState extends ComicDetailState {
  final String error;

  const ErrorComicDetailState(this.error);

  @override
  List<Object?> get props => [error];
}

class UpdateStatusFollowingComicSuccessful extends ComicDetailState {
  final String message;

  const UpdateStatusFollowingComicSuccessful({required this.message});
  @override
  List<Object?> get props => [message];
}

class UpdateStatusFollowingComicFailure extends ComicDetailState {
  final String message;

  const UpdateStatusFollowingComicFailure({required this.message});
  @override
  List<Object?> get props => [message];
}

class RatingComicSuccessful extends ComicDetailState {
  final String message;

  const RatingComicSuccessful({required this.message});
  @override
  List<Object?> get props => [message];
}

class RatingComicFailure extends ComicDetailState {
  final String message;

  const RatingComicFailure({required this.message});
  @override
  List<Object?> get props => [message];
}
