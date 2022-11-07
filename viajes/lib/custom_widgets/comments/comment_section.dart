import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'dart:async';

import 'bloc/comment_bloc.dart';
import 'comment_tile.dart';

late StreamSubscription<bool> keyboardSubscription;

class CommentSection extends StatefulWidget {
  final GlobalKey<State<StatefulWidget>>? anchor;
  final parentID; // Experience ID / Place ID (low prio)

  CommentSection({
    super.key,
    required this.parentID,
    this.anchor,
  });

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final commentController = TextEditingController();
  final replyController = TextEditingController();
  late FocusNode replyBoxFocusNode;
  late FocusNode commentBoxFocusNode;
  late StreamSubscription<bool> keyboardSubscription;
  bool _replyBoxVisibility = false;

  @override
  void initState() {
    super.initState();
//TODO: Focus Issue (duplicate replyBox)
    replyBoxFocusNode = FocusNode();
    commentBoxFocusNode = FocusNode();

    var keyboardVisibilityController = KeyboardVisibilityController();

    // Subscribe when keyboard on focus
    keyboardSubscription =
        keyboardVisibilityController.onChange.listen((bool visible) {
      if (!visible) {
        FocusScope.of(context).unfocus();
        _replyBoxVisibility = false;
      }
    });
  }

  @override
  void dispose() {
    commentBoxFocusNode.dispose();
    replyBoxFocusNode.dispose();
    super.dispose();
  }

  // final comments = ['Wow', 'Thanks for sharing', 'Rad', 'Is this really free?'];
  // final replies = [
  //   'Yes!',
  //   'Awesome!',
  //   'Lol I photobombed you',
  //   'That was helpful',
  //   'I agree',
  //   'Hmmm you forgot to mention how you got there. Does anybody know how to? I\'m really lost',
  //   'I have some other questions, can I DM you?',
  //   'Wait, you can do that?'
  // ];

  @override
  Widget build(BuildContext context) {
    var focusedComment = {};
    var experienceComments = [];

    ///
    return BlocConsumer<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state is CommentInitial) {
          BlocProvider.of<CommentBloc>(context)
              .add(GetExperienceComments(experienceID: null));
        } else if (state is GeneralErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('state.msg')),
          );
        } else if (state is LoadingCommentsState) {
          // TODO: Implement loading animations
        } else if (state is LoadingRepliesState) {
          // TODO: Implement loading animations
        } else if (state is RefreshCommentsState) {
          experienceComments = state.comments;
        } else if (state is RefreshRepliesState) {
          experienceComments = state.replies;
          _replyBoxVisibility = false;
          _showReplies(context, focusedComment, state.replies);
        } else if (state is FocusCommentBoxState) {
          focusedComment = state.mainComment;
          replyBoxFocusNode.requestFocus();
          _replyBoxVisibility = true;
        } else if (state is ShowRepliesRequestState) {
          _replyBoxVisibility = false;
          _showReplies(context, state.mainComment, state.replies);
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(22, 22, 22, 0),
                  child: Column(
                    children: [
                      Divider(thickness: 2),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Comments (${experienceComments.length})",
                              style: Theme.of(context).textTheme.headline6)),
                      Divider(thickness: 2),
                      _writeBox(context, commentController, commentBoxFocusNode,
                          '', commentType.comment),
                      SizedBox(key: widget.anchor, height: 5),
                      _commentList(context, experienceComments, null,
                          widget.parentID, commentType.comment),
                      //SizedBox(height: 50),
                    ],
                  )),
              _replyBox(context, focusedComment),
            ],
          ),
        );
      },
    );
  }

  Container _writeBox(BuildContext context, TextEditingController controller,
      FocusNode focusNode, String labelText, commentType type,
      [rootCommentID]) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      child: Row(
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Scrollbar(
                radius: Radius.circular(15),
                child: TextField(
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: "Leave a comment",
                      labelText: labelText,
                      contentPadding: EdgeInsets.only(left: 10, top: 7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )),
              ),
            ),
          ),
          IconButton(
              icon: FaIcon(FontAwesomeIcons.solidPaperPlane),
              onPressed: () {
                // TODO: Post comment/reply
                if (type == commentType.comment) {
                  BlocProvider.of<CommentBloc>(context).add(PostCommentEvent(
                      comment: controller.toString(),
                      experienceID: widget.parentID));
                } else if (type == commentType.reply && rootCommentID != null) {
                  BlocProvider.of<CommentBloc>(context).add(PostReplyEvent(
                      reply: controller.toString(),
                      rootCommentID: rootCommentID));
                }
                FocusManager.instance.primaryFocus?.unfocus();
                controller.clear();
              }),
        ],
      ),
    );
  }

  Widget _commentList(BuildContext context, comments, ScrollController? sc,
      parentID, commentType type) {
    return ListView.builder(
      controller: sc,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      padding: EdgeInsets.all(5),
      scrollDirection: Axis.vertical,
      itemCount: comments.length,
      itemBuilder: (BuildContext context, int index) {
        return CommentTile(
            comment: comments[index],
            parentID: parentID,
            type: type); // ExperienceID/RootCommentID
      },
    );
  }

  _showReplies(BuildContext context, Map mainComment, List replies) {
    showBarModalBottomSheet(
        backgroundColor: Colors.blue,
        elevation: 1,
        enableDrag: true,
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    border: Border.all(color: Colors.blueAccent)),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    _repliesList(ModalScrollController.of(context), mainComment,
                        replies),
                    _replyBox(context, mainComment),
                  ],
                )),
          );
        });
  }

  Widget _repliesList(ScrollController? sc, Map mainComment, List replies) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.02,
                right: MediaQuery.of(context).size.width * 0.02),
            child: CommentTile(
                comment: mainComment,
                parentID: widget.parentID,
                type: commentType.comment),
          ),
          Divider(thickness: 2),
          Container(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.02),
            child: _commentList(
                context, replies, sc, widget.parentID, commentType.reply),
          ),
        ],
      ),
    );
  }

  Positioned _replyBox(BuildContext context, Map mainComment) {
    return Positioned(
      bottom: MediaQuery.of(context).viewInsets.bottom,
      left: 0,
      right: 0,
      child: Visibility(
        visible: _replyBoxVisibility,
        child: Material(
          elevation: 4,
          child: Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            child: Column(
              children: [
                ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      // TODO: Send to ProfilePage, arg: mainComment['userID']
                    },
                    child: CircleAvatar(
                        radius: 18,
                        child: Icon(Icons.person),
                        backgroundColor:
                            Theme.of(context).listTileTheme.iconColor),
                  ),
                  title: _writeBox(
                      context,
                      replyController,
                      replyBoxFocusNode,
                      'Replying to ${mainComment['username']}',
                      commentType.reply,
                      mainComment['commentID']),
                ),
              ],
            ),
            decoration:
                BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
          ),
        ),
      ),
    );
  }
}
