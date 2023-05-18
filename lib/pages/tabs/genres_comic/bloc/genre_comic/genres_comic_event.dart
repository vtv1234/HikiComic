part of 'genres_comic_bloc.dart';

abstract class GenresComicEvent extends Equatable {
  const GenresComicEvent();
}

class LoadComicOfGenresEvent extends GenresComicEvent {
  final Genre genre;

  LoadComicOfGenresEvent({required this.genre});
  @override
  List<Object?> get props => [];
}
