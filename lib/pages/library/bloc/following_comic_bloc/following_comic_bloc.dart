import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/comic.dart';
import 'package:hikicomic/data/models/history_comic.dart';
import 'package:hikicomic/repository/comic_reading_histories_repository.dart';
import 'package:hikicomic/repository/comic_repository.dart';

part 'following_comic_event.dart';
part 'following_comic_state.dart';

class FollowingComicBloc extends Bloc<FollowingEvent, FollowingComicState> {
  final ComicRepository _comicRepository = ComicRepository();
  FollowingComicBloc() : super(FollowingComicLoading()) {
    on<LoadFollowingComicEvent>((event, emit) async {
      emit(FollowingComicLoading());
      try {
        final List<Comic> followingComic =
            await _comicRepository.getFollowingComics();
        emit(FollowingComicLoaded(followingComic));
      } catch (e) {
        emit(FollowingComicError(e.toString()));
      }
    });
  }
}
