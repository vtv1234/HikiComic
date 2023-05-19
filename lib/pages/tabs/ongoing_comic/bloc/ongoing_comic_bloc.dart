import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/comic.dart';
import 'package:hikicomic/repository/comic_repository.dart';

part 'ongoing_comic_event.dart';
part 'ongoing_comic_state.dart';

class OngoingComicBloc extends Bloc<OngoingComicEvent, OngoingComicState> {
  final ComicRepository _comicRepository = ComicRepository();

  OngoingComicBloc() : super(OngoingComicInitial()) {
    on<LoadOngoingComicEvent>((event, emit) async {
      // emit(OngoingComicLoadingState());
      try {
        emit(OngoingComicLoading());
        final ongoingComics = await _comicRepository.getHotComicsOfDay();
        emit(OngoingComicLoaded(ongoingComics));
        // if(ongoingComics!= null){}
      } catch (e) {
        emit(OngoingComicError(e.toString()));
      }
    });
  }
}
