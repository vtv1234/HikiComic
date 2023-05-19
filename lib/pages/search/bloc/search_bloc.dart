import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hikicomic/data/models/comic.dart';
import 'package:hikicomic/repository/comic_repository.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ComicRepository _comicRepository = ComicRepository();

  SearchBloc() : super(SearchStateLoading()) {
    on<SearchEvent>((event, emit) async {
      try {
        List<Comic> listComics = await _comicRepository.getComicsByKeyword(
            keyword: event.keyword, pageIndex: 1, pageSize: 1000);
        List<Comic> listHotComics =
            await _comicRepository.getHotComicsOfMonth();
        emit(SearchStateSuccess(listComics, listHotComics));
      } catch (e) {
        emit(SearchStateError(e.toString()));
      }
    });
  }

  void init() async {}
}
