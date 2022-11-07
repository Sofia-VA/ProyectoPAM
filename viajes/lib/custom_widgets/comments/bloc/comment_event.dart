part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object> get props => [];
}

class GetExperienceComments extends CommentEvent {
  final experienceID;

  GetExperienceComments({required this.experienceID});

  @override
  List<Object> get props => [experienceID];
}

class WriteToCommentBoxEvent extends CommentEvent {
  final Map mainComment;

  WriteToCommentBoxEvent({required this.mainComment});

  @override
  List<Object> get props => [mainComment];
}

class ShowRepliesEvent extends CommentEvent {
  final commentID;

  ShowRepliesEvent({required this.commentID});
  @override
  List<Object> get props => [commentID];
}

class LikeCommentEvent extends CommentEvent {
  final commentID;

  LikeCommentEvent({required this.commentID});
  @override
  List<Object> get props => [commentID];
}

class PostCommentEvent extends CommentEvent {
  final String comment;
  final experienceID;

  PostCommentEvent({required this.comment, required this.experienceID});
  @override
  List<Object> get props => [comment, experienceID];
}

class PostReplyEvent extends CommentEvent {
  final String reply;
  final rootCommentID;

  PostReplyEvent({required this.reply, required this.rootCommentID});
  @override
  List<Object> get props => [reply, rootCommentID];
}

class DeleteCommentEvent extends CommentEvent {
  final commentID;
  final experienceID;

  DeleteCommentEvent({required this.commentID, required this.experienceID});
  @override
  List<Object> get props => [commentID, experienceID];
}

class DeleteReplyEvent extends CommentEvent {
  final commentID;
  final rootCommentID;

  DeleteReplyEvent({required this.commentID, required this.rootCommentID});
  @override
  List<Object> get props => [commentID, rootCommentID];
}

class EditCommentEvent extends CommentEvent {
  final commentID;

  EditCommentEvent({required this.commentID});
  @override
  List<Object> get props => [commentID];
}

class UpdateCommentEvent extends CommentEvent {
  final String newComment;
  final commentID;
  final experienceID;

  UpdateCommentEvent(
      {required this.newComment,
      required this.commentID,
      required this.experienceID});
  @override
  List<Object> get props => [newComment, commentID, experienceID];
}

class UpdateReplyEvent extends CommentEvent {
  final String newReply;
  final commentID;
  final rootCommentID;

  UpdateReplyEvent(
      {required this.newReply,
      required this.commentID,
      required this.rootCommentID});
  @override
  List<Object> get props => [newReply, commentID, rootCommentID];
}
