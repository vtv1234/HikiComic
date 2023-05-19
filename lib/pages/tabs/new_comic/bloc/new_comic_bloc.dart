
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/comic.dart';
import 'package:hikicomic/repository/comic_repository.dart';

part 'new_comic_event.dart';
part 'new_comic_state.dart';

class NewComicBloc extends Bloc<NewComicEvent, NewComicState> {
  final ComicRepository _comicRepository;

  NewComicBloc(this._comicRepository) : super(NewComicLoadingState()) {
    on<LoadNewComicEvent>((event, emit) async {
      emit(NewComicLoadingState());
      try {
        final trendingComics = await _comicRepository.getNewComics(
            pageIndex: event.pageIndex, pageSize: event.pageSize);
        emit(NewComicLoadedState(trendingComics));
      } catch (e) {
        emit(NewComicErrorState(e.toString()));
      }
    });
  }
}
