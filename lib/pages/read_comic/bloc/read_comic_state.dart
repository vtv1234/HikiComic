part of 'read_comic_bloc.dart';

abstract class ReadComicState extends Equatable {
  const ReadComicState();
}

class LoadingChapterImageState extends ReadComicState {
  @override
  List<Object?> get props => [];
}

class LoadedChapterImageState extends ReadComicState {
  final ChapterImage chapterImage;

  LoadedChapterImageState(this.chapterImage);

  @override
  List<Object?> get props => [chapterImage];
}

class ErrorChapterImageState extends ReadComicState {
  final String error;

  ErrorChapterImageState(this.error);

  @override
  List<Object?> get props => [error];
}
