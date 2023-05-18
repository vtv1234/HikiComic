part of 'read_comic_bloc.dart';

abstract class ReadComicEvent extends Equatable {
  const ReadComicEvent();

  // @override
  // List<Object> get props => [];
}

class LoadChapterImageEvent extends ReadComicEvent {
  final String comicSeoAlias;
  final String chapterSeoAlias;

  const LoadChapterImageEvent(this.comicSeoAlias, this.chapterSeoAlias);

  @override
  List<Object?> get props => [comicSeoAlias, chapterSeoAlias];
}

// class LoadNextChapter extends ReadComicEvent{}
// class ErrorLoadChapterImageEvent extends ReadComicEvent {
//   final String error;

//   const ErrorLoadChapterImageEvent(this.error);

//   @override
//   List<Object?> get props => [error];
// }
