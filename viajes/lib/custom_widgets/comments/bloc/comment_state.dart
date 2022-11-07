part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  const CommentState();

  @override
  List<Object> get props => [];
}

class CommentInitial extends CommentState {}

class FocusCommentBoxState extends CommentState {
  final mainComment;

  FocusCommentBoxState({required this.mainComment});
  @override
  List<Object> get props => [mainComment];
}

class LoadingCommentsState extends CommentState {}

class LoadingRepliesState extends CommentState {}

class ShowRepliesRequestState extends CommentState {
  final mainComment;
  final List replies;

  ShowRepliesRequestState({required this.mainComment, required this.replies});

  @override
  List<Object> get props => [mainComment, replies];
}

class SuccessLikedCommentState extends CommentState {
  final String msg;

  SuccessLikedCommentState(this.msg);
  @override
  List<Object> get props => [msg];
}

// On success commenting, deleting, updating
class RefreshCommentsState extends CommentState {
  final List comments;

  RefreshCommentsState({required this.comments});
  @override
  List<Object> get props => [comments];
}

// On success replying, deleting, updating
class RefreshRepliesState extends CommentState {
  final List replies;

  RefreshRepliesState({required this.replies});
  @override
  List<Object> get props => [replies];
}

class GeneralErrorState extends CommentState {
  final String msg;

  GeneralErrorState(this.msg);
  @override
  List<Object> get props => [msg];
}
