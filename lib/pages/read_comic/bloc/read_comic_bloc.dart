import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/chapter.dart';
import 'package:hikicomic/data/models/chapter_image.dart';
import 'package:hikicomic/repository/chapter_image_repository.dart';
import 'package:hikicomic/repository/chapter_repository.dart';

part 'read_comic_event.dart';
part 'read_comic_state.dart';

class ReadComicBloc extends Bloc<ReadComicEvent, ReadComicState> {
  final ChapterImageRepository _chapterImageRepository =
      ChapterImageRepository();
  final ChapterRepository _chapterRepository = ChapterRepository();

  ReadComicBloc() : super((LoadingChapterImageState())) {
    on<LoadChapterImageEvent>((event, emit) async {
      emit(LoadingChapterImageState());
      try {
        final chapterImageResult =
            await _chapterImageRepository.getChaptersByChapterComicSeoAlias(
                event.comicSeoAlias, event.chapterSeoAlias);
        if (chapterImageResult.isSuccessed == true) {
          emit(LoadedChapterImageState(chapterImageResult.ressultObj));
        } else {
          emit(ErrorChapterImageState(chapterImageResult.message!));
        }
      } catch (e) {
        emit(ErrorChapterImageState(e.toString()));
      }
    });
    on<LoadListChapterEvent>(
      (event, emit) async {
        emit(LoadingListChapterState());
        try {
          final chapters = await _chapterRepository
              .getChaptersByComicSeoAlias(event.comicSeoAlias);
          emit(LoadedListChapterState(chapters.ressultObj));
        } catch (e) {
          emit(ErrorListChapterState(e.toString()));
        }
      },
    );
  }
}
