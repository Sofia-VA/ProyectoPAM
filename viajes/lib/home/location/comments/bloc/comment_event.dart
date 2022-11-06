part of 'comment_bloc.dart';

abstract class CommentEvent {}

class WriteToCommentBoxEvent extends CommentEvent {}

class ShowRepliesEvent extends CommentEvent {}
