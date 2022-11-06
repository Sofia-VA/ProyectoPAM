part of 'comment_bloc.dart';

@immutable
abstract class CommentState {}

class CommentInitial extends CommentState {}

class FocusCommentBoxState extends CommentState {}

class ShowRepliesRequestState extends CommentState {}
