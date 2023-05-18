import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hikicomic/data/models/comic.dart';
import 'package:hikicomic/data/models/genre.dart';
import 'package:hikicomic/repository/genres_repository.dart';
import 'package:http/http.dart';

part 'genres_comic_event.dart';
part 'genres_comic_state.dart';

class GenresComicBloc extends Bloc<GenresComicEvent, GenresComicState> {
  final GenresRepository _genresRepository = GenresRepository();
  GenresComicBloc() : super(GenresComicInitial()) {
    on<LoadComicOfGenresEvent>(_handleLoadComicOfGenresEvent);
  }

  Future<FutureOr<void>> _handleLoadComicOfGenresEvent(
      LoadComicOfGenresEvent event, Emitter<GenresComicState> emit) async {
    emit(LoadingComicOfGenre());
    try {
      final listComicByGenre = await _genresRepository.getComicByGenre(
          genreId: event.genre.genreId!,
          keyword: '',
          pageIndex: 1,
          pageSize: 30);
      if (listComicByGenre.isNotEmpty) {
        emit(LoadComicOfGenreSuccess(comicOfGenre: listComicByGenre));
      } else {
        emit(LoadComicOfGenreFailure(error: "There's no comic in this genre"));
      }
    } catch (e) {
      emit(LoadComicOfGenreFailure(error: e.toString()));
    }
  }
}
