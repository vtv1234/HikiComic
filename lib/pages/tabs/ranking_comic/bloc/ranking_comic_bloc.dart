import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hikicomic/data/models/comic.dart';
import 'package:hikicomic/repository/comic_repository.dart';

part 'ranking_comic_event.dart';
part 'ranking_comic_state.dart';

class RankingComicBloc extends Bloc<RankingComicEvent, RankingComicState> {
  final ComicRepository _comicRepository = ComicRepository();

  RankingComicBloc() : super(RankingComicLoadingState()) {
    on<LoadRankingComicEvent>((event, emit) async {
      emit(RankingComicLoadingState());
      try {
        final rankingComic = await _comicRepository.getHotComicsOfDay();
        emit(RankingComicLoadedState(rankingComic));
      } catch (e) {
        emit(RankingComicErrorState(e.toString()));
      }
    });
  }
}
