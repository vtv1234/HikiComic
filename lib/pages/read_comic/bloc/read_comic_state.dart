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

  const LoadedChapterImageState(this.chapterImage);

  @override
  List<Object?> get props => [chapterImage];
}

class ErrorChapterImageState extends ReadComicState {
  final String error;

  const ErrorChapterImageState(this.error);

  @override
  List<Object?> get props => [error];
}
