part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class GetListCommentOfChapter extends CommentEvent {
  final int comicId;
  final int? chapterId;

  const GetListCommentOfChapter(this.comicId, this.chapterId);
}

class SendComment extends CommentEvent {
  final String commentContent;
  final int comicId;
  final int? chapterId;
  final int? parrentCommentId;

  const SendComment(
      {required this.commentContent,
      required this.comicId,
      required this.chapterId,
      required this.parrentCommentId});
}
