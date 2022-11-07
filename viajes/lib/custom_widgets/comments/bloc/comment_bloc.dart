import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  Map userCommentData = {};
  Map get getUserCommentData => userCommentData;

  CommentBloc() : super(CommentInitial()) {
    userCommentData = _getUserCommentData();
    on<GetExperienceComments>(_getExperienceComments);
    on<WriteToCommentBoxEvent>(_changeFocus);
    on<ShowRepliesEvent>(_showReplies);
    on<LikeCommentEvent>(_likeComment);
    on<PostCommentEvent>(_postComment);
    on<PostReplyEvent>(_postReply);
    on<DeleteCommentEvent>(_deleteComment);
    on<DeleteReplyEvent>(_deleteReply);
    on<UpdateCommentEvent>(_updateComment);
    on<UpdateReplyEvent>(_updateReply);
  }

  FutureOr<void> _getExperienceComments(
      GetExperienceComments event, Emitter<CommentState> emit) {
    emit(LoadingCommentsState());
    final comments = _getComments(event.experienceID);
    emit(RefreshCommentsState(comments: comments));
  }

  FutureOr<void> _changeFocus(
      WriteToCommentBoxEvent event, Emitter<CommentState> emit) {
    emit(FocusCommentBoxState(mainComment: event.mainComment));
  }

  FutureOr<void> _showReplies(
      ShowRepliesEvent event, Emitter<CommentState> emit) {
    emit(LoadingRepliesState());
    // TODO: Get mainComent event.commentID
    final mainComment = {};
    // TODO: Get replies event.commentID
    final replies = [];

    emit(ShowRepliesRequestState(mainComment: mainComment, replies: replies));
  }

  FutureOr<void> _likeComment(
      LikeCommentEvent event, Emitter<CommentState> emit) {
    try {
      // TODO: Add to like count in targetcomment event.commentID
      final username = '';
      // TODO: VERIFY: Add commentID to userCommentData
      userCommentData['likedComments'].add(event.commentID);

      // On success:
      emit(SuccessLikedCommentState('You liked ${username}\'s comment'));
    } catch (e) {
      // On failure
      emit(GeneralErrorState('Failure liking comment'));
    }
  }

  FutureOr<void> _postComment(
      PostCommentEvent event, Emitter<CommentState> emit) {
    try {
      if (event.comment.isEmpty) {
        emit(GeneralErrorState('Cannot post a blank comment'));
        return null;
      }
      // TODO: Add to user comments inside their event.experienceID
      //event.comment
      final newCommentID = '';
      // Update userCommentData (add new ID)
      userCommentData['experienceComments'].add(newCommentID);
      // TODO: Get Comments
      emit(LoadingCommentsState());
      final updatedComments = _getComments(event.experienceID);
      emit(RefreshCommentsState(comments: updatedComments));
    } catch (e) {
      emit(GeneralErrorState('Failure posting comment'));
    }
  }

  FutureOr<void> _postReply(PostReplyEvent event, Emitter<CommentState> emit) {
    try {
      if (event.reply.isEmpty) {
        emit(GeneralErrorState('Cannot post a blank reply'));
        return null;
      }
      // TODO: Add to user replies inside their event.experienceID
      //event.reply
      final newReplyID = '';
      // Update userCommentData (add new ID)
      userCommentData['experienceComments'].add(newReplyID);
      // TODO: Get Replies
      emit(LoadingRepliesState());
      final updatedReplies = _getReplies(event.rootCommentID);
      emit(RefreshRepliesState(replies: updatedReplies));
    } catch (e) {
      emit(GeneralErrorState('Failure replying to comment'));
    }
  }

  FutureOr<void> _deleteComment(
      DeleteCommentEvent event, Emitter<CommentState> emit) {
    try {
      // TODO: Search and delete event.commentID from user (db)

      userCommentData['experienceComments']
          .remove(event.commentID); // Check ..remove()

      // TODO: Get Comments
      emit(LoadingCommentsState());
      final updatedComments = _getComments(event.experienceID);
      emit(RefreshCommentsState(comments: updatedComments));
    } catch (e) {
      emit(GeneralErrorState('Failure deleting comment'));
    }
  }

  FutureOr<void> _deleteReply(
      DeleteReplyEvent event, Emitter<CommentState> emit) {
    try {
      // TODO: Search and delete event.commentID from user (db)

      userCommentData['experienceComments']
          .remove(event.commentID); // Check ..remove()

      // TODO: Get Replies
      emit(LoadingRepliesState());
      final updatedReplies = _getComments(event.rootCommentID);
      emit(RefreshRepliesState(replies: updatedReplies));
    } catch (e) {
      emit(GeneralErrorState('Failure deleting reply'));
    }
  }

  FutureOr<void> _updateComment(
      UpdateCommentEvent event, Emitter<CommentState> emit) {
    try {
      //Update value in database for event.commentID (to event.newComment)

      //No need to update userCommentData

      // TODO: Get Comments
      emit(LoadingCommentsState());
      final updatedComments = _getComments(event.experienceID);
      emit(RefreshCommentsState(comments: updatedComments));
    } catch (e) {
      emit(GeneralErrorState('Failure updating comment'));
    }
  }

  FutureOr<void> _updateReply(
      UpdateReplyEvent event, Emitter<CommentState> emit) {
    try {
      //Update value in database for event.commentID (to event.newComment)

      //No need to update userCommentData

      // TODO: Get Replies
      emit(LoadingRepliesState());
      final updatedReplies = _getReplies(event.rootCommentID);
      emit(RefreshRepliesState(replies: updatedReplies));
    } catch (e) {
      emit(GeneralErrorState('Failure updating reply'));
    }
  }

  Map _getUserCommentData() {
    // TODO: Search and get user comment data

    // experienceComments -> All reply and comment IDs of this experience
    // likedComments -> All IDs of liked comments
    return {};
  }

  List _getComments(experienceID) {
    // TODO: Get comments of experience from DB
    return [];
  }

  List _getReplies(rootCommentID) {
    // TODO: Get replies of rootComment from DB
    return [];
  }
}
