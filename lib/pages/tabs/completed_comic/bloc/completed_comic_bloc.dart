import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/comic.dart';
import 'package:hikicomic/repository/comic_repository.dart';

part 'completed_comic_event.dart';
part 'completed_comic_state.dart';

class CompletedComicBloc
    extends Bloc<CompletedComicEvent, CompletedComicState> {
  final ComicRepository _comicRepository = ComicRepository();

  CompletedComicBloc() : super(CompletedComicLoadingState()) {
    on<LoadCompletedComicEvent>((event, emit) async {
      emit(CompletedComicLoadingState());
      try {
        final completedComics = await _comicRepository.getComicsByStatus(
            pageIndex: 1, pageSize: 30, statusId: 4);
        emit(CompletedComicLoadedState(completedComics));
      } catch (e) {
        emit(CompletedComicErrorState(e.toString()));
      }
    });
  }
}
