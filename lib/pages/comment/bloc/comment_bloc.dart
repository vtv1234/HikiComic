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
        final List<Comment>? result =
            await _commentRepository.getListCommentOfChapter(
                comicId: event.comicId,
                chapterId: event.chapterId,
                pageIndex: 1,
                pageSize: 30);
        emit(CommentLoadedSuccessful(result));
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
