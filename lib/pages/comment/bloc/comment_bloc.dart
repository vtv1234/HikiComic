import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hikicomic/data/models/comment.dart';
import 'package:hikicomic/repository/comment_repository.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentRepository _commentRepository = CommentRepository();
  CommentBloc() : super(CommentInitial()) {
    on<GetListCommentOfChapter>((event, emit) async {
      emit(CommentLoading());
      try {
<<<<<<< Updated upstream
        final List<Comment>? result =
            await _commentRepository.getListCommentOfChapter(
                comicId: event.comicId,
                chapterId: event.chapterId,
                pageIndex: 1,
                pageSize: 30);
        emit(CommentLoadedSuccessful(result));
=======
        // if (event.isLoading) return;
        // emit()
        final List<Comment>? result = await _commentRepository.getListComment(
            comicId: event.comicId,
            chapterId: event.chapterId,
            pageIndex: event.pageIndex,
            pageSize: 10);

        emit(CommentLoadedSuccessful(
            listComment: result,
            hasMore: result!.length < 10 ? false : true,
            pageIndex: event.pageIndex + 1,
            isLoading: false));
>>>>>>> Stashed changes
      } catch (e) {
        emit(CommentLoadedFailure(e.toString()));
      }
    });
    on<SendComment>((event, emit) async {
      emit(CommentLoading());
      try {
        final responseResult = await _commentRepository.sendComment(
            chapterId: event.chapterId,
            comicId: event.comicId,
            commentContent: event.commentContent,
            parentCommentId: event.parrentCommentId);
        if (responseResult.isSuccessed == true) {
          emit(SendedCommentSuccess(responseResult.ressultObj));
        } else {
          emit(SendedCommentFail(responseResult.message!));
        }
      } catch (e) {
        emit(SendedCommentFail(e.toString()));
      }
    });
  }
}
