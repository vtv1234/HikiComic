part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class GetListComment extends CommentEvent {
  final int comicId;
  final int? chapterId;
  final int pageIndex;
  final bool isLoading;

  const GetListComment({
    required this.comicId,
    this.chapterId,
    required this.pageIndex,
    required this.isLoading,
  });
}

class SendComment extends CommentEvent {
  final String commentContent;
  final int comicId;
  final int? chapterId;
  final int? parentCommentId;

  const SendComment(
      {required this.commentContent,
      required this.comicId,
      required this.chapterId,
      required this.parentCommentId});
}

class ReplyComment extends CommentEvent {
  final int parentCommentId;
  final String parentUsername;

  ReplyComment({required this.parentCommentId, required this.parentUsername});
}
