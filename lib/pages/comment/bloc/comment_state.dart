part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoadedSuccessful extends CommentState {
  final List<Comment>? listComment;
  final bool hasMore;
  final int pageIndex;

  final bool isLoading;

  const CommentLoadedSuccessful({
    this.listComment,
    required this.hasMore,
    required this.pageIndex,
    required this.isLoading,
  });
  @override
  List<Object> get props => [listComment!, hasMore];
}

class CommentLoadedFailure extends CommentState {
  final String error;

  const CommentLoadedFailure(this.error);
  @override
  List<Object> get props => [error];
}

class SendingComment extends CommentState {}

class SendedCommentSuccess extends CommentState {
  final Comment sendedComment;

  const SendedCommentSuccess(this.sendedComment);
}

class SendedCommentFail extends CommentState {
  final String error;

  const SendedCommentFail(this.error);
}

class ReplyingComment extends CommentState {
  final String replyUsername;

  ReplyingComment(this.replyUsername);
  @override
  // TODO: implement props
  List<Object> get props => [replyUsername];
}
