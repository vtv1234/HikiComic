import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/chapter.dart';
import 'package:hikicomic/data/models/comic_detail.dart';
import 'package:hikicomic/data/models/response.dart';
import 'package:hikicomic/repository/chapter_repository.dart';
import 'package:hikicomic/repository/comic_detail_repository.dart';

import 'package:hikicomic/utils/utils.dart';

part 'comic_detail_event.dart';
part 'comic_detail_state.dart';

class ComicDetailBloc extends Bloc<ComicDetailEvent, ComicDetailState> {
  final ComicDetailRepository _comicDetailRepository;
  final ChapterRepository _chapterRepository;
  final Utils utils = Utils();

  ComicDetailBloc(this._comicDetailRepository, this._chapterRepository)
      : super(LoadingComicDetailState()) {
    on<LoadComicDetailEvent>((event, emit) async {
      emit(LoadingComicDetailState());
      try {
        final comicDetail = await _comicDetailRepository
            .getComicDetailByComicSeoAlias(event.comicSeoAlias);
        final chapters = await _chapterRepository
            .getChaptersByComicSeoAlias(event.comicSeoAlias);
        emit(LoadedComicDetailState(comicDetail.resultObj, chapters.resultObj));
      } catch (e) {
        emit(ErrorComicDetailState(e.toString()));
      }
    });
    on<UpdateStatusFollowingComic>(_handleUpdateStatusFollowingComic);
    on<RatingComicEvent>(_handleRatingComicEvent);
  }

  Future<FutureOr<void>> _handleUpdateStatusFollowingComic(
      UpdateStatusFollowingComic event, Emitter<ComicDetailState> emit) async {
    try {
      final BaseResponse response = await _comicDetailRepository
          .updateStatusUserFollowComic(event.comicId);
      emit(UpdateStatusFollowingComicSuccessful(message: response.message!));
    } catch (e) {
      emit(UpdateStatusFollowingComicFailure(message: e.toString()));
    }
  }

  Future<FutureOr<void>> _handleRatingComicEvent(
      RatingComicEvent event, Emitter<ComicDetailState> emit) async {
    if (await utils.methodLogin() != "") {
      try {
        final BaseResponse response = await _comicDetailRepository.ratingComic(
            comicId: event.comicId,
            comicSEOAlias: event.comicSEOAlias,
            rating: event.rating);
        emit(RatingComicSuccessful(message: response.message!));
      } catch (e) {
        emit(RatingComicFailure(message: e.toString()));
      }
    } else {
      emit(const RatingComicFailure(
          message: "You have to sign in to rating this comic"));
    }
  }
}
