import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/history_comic.dart';
import 'package:hikicomic/repository/comic_reading_histories_repository.dart';

part 'recent_comic_event.dart';
part 'recent_comic_state.dart';

class RecentComicBloc extends Bloc<RecentEvent, RecentComicState> {
  final ComicReadingHistoriesRepository _comicReadingHistoriesRepository =
      ComicReadingHistoriesRepository();
  RecentComicBloc() : super(RecentComicLoading()) {
    on<LoadRecentComicEvent>((event, emit) async {
      emit(RecentComicLoading());
      try {
        final List<HistoryComic> recentComic =
            await _comicReadingHistoriesRepository.getComicReadingHistories();
        emit(RecentComicLoaded(recentComic));
      } catch (e) {
        emit(RecentComicError(e.toString()));
      }
    });
  }
}
