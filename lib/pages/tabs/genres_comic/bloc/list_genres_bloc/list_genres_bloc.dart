import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/genre.dart';

import 'package:hikicomic/repository/genres_repository.dart';

part 'list_genres_event.dart';
part 'list_genres_state.dart';

class ListGenresBloc extends Bloc<ListGenresEvent, ListGenresState> {
  final GenresRepository _genresRepository = GenresRepository();

  ListGenresBloc() : super(ListGenresInitial()) {
    on<LoadAllGenresEvent>(_handleLoadListGenresEvent);
  }
  FutureOr<void> _handleLoadListGenresEvent(event, emit) async {
    emit(const LoadingListGenres());
    try {
      final result = await _genresRepository.getAllGenres();
      if (result.isSuccessed == true) {
        emit(LoadListGenresSuccess(
            listAllGenres: result.ressultObj,
            indexSelectedGenre: event.indexSelectedGenre));
      } else {
        emit(LoadListGenresFailure(result.message!));
      }
    } catch (e) {
      emit(LoadListGenresFailure(e.toString()));
    }
  }
}
