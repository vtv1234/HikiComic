part of 'comic_detail_bloc.dart';

abstract class ComicDetailEvent extends Equatable {
  const ComicDetailEvent();
}

class LoadComicDetailEvent extends ComicDetailEvent {
  final String comicSeoAlias;

  const LoadComicDetailEvent(this.comicSeoAlias);
  @override
  List<Object?> get props => [comicSeoAlias];
}

class RatingComicEvent extends ComicDetailEvent {
  final int comicId;
  final String comicSEOAlias;
  final double rating;

  const RatingComicEvent(
      {required this.comicId,
      required this.comicSEOAlias,
      required this.rating});
  @override
  List<Object?> get props => [comicId, comicSEOAlias, rating];
}

class UpdateStatusFollowingComic extends ComicDetailEvent {
  final int comicId;

  const UpdateStatusFollowingComic(this.comicId);
  @override
  List<Object?> get props => [comicId];
}
