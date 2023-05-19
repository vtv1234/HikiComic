part of 'genres_comic_bloc.dart';

abstract class GenresComicState extends Equatable {
  const GenresComicState();
}

class GenresComicInitial extends GenresComicState {
  @override
  List<Object?> get props => [];
}

class LoadingComicOfGenre extends GenresComicState {
  @override
  List<Object?> get props => [];
}

class LoadComicOfGenreSuccess extends GenresComicState {
  final List<Comic> comicOfGenre;

  const LoadComicOfGenreSuccess({required this.comicOfGenre});

  @override
  List<Object?> get props => [comicOfGenre];
}

class LoadComicOfGenreFailure extends GenresComicState {
  final String error;

  const LoadComicOfGenreFailure({required this.error});

  @override
  List<Object?> get props => [];
}
