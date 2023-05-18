import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/chapter_image.dart';
import 'package:hikicomic/data/models/error_auth.dart';
import 'package:hikicomic/repository/chapter_image_repository.dart';

part 'read_comic_event.dart';
part 'read_comic_state.dart';

class ReadComicBloc extends Bloc<ReadComicEvent, ReadComicState> {
  final ChapterImageRepository _chapterImageRepository =
      ChapterImageRepository();
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
  }
}
