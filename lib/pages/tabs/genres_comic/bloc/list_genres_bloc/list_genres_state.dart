part of 'list_genres_bloc.dart';

abstract class ListGenresState extends Equatable {
  const ListGenresState();
}

class ListGenresInitial extends ListGenresState {
  @override
  List<Object?> get props => [];
}

class LoadingListGenres extends ListGenresState {
  // final int indexSelectedGenre;

  const LoadingListGenres();
  @override
  List<Object?> get props => [];
}

class LoadListGenresSuccess extends ListGenresState {
  final int indexSelectedGenre;
  final List<Genre> listAllGenres;

  const LoadListGenresSuccess(
      {required this.listAllGenres, required this.indexSelectedGenre});

  @override
  List<Object?> get props => [listAllGenres, indexSelectedGenre];
}

class LoadListGenresFailure extends ListGenresState {
  final String error;

  const LoadListGenresFailure(this.error);

  @override
  List<Object?> get props => [];
}
