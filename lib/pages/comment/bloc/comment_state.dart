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

  CommentLoadedSuccessful(this.listComment);
  @override
  // TODO: implement props
  List<Object> get props => [listComment!];
}

class CommentLoadedFailure extends CommentState {
  final String error;

  CommentLoadedFailure(this.error);
  @override
  // TODO: implement props
  List<Object> get props => [error];
}

class SendingComment extends CommentState {}

class SendedCommentSuccess extends CommentState {
  final Comment sendedComment;

  SendedCommentSuccess(this.sendedComment);
}

class SendedCommentFail extends CommentState {
  final String error;

  SendedCommentFail(this.error);
}
