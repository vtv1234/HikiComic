part of 'list_genres_bloc.dart';

abstract class ListGenresEvent extends Equatable {
  const ListGenresEvent();
}

class LoadAllGenresEvent extends ListGenresEvent {
  final int indexSelectedGenre;

  const LoadAllGenresEvent({required this.indexSelectedGenre});
  @override
  List<Object?> get props => [indexSelectedGenre];
}
