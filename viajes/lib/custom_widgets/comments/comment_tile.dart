import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'bloc/comment_bloc.dart';

enum commentType { comment, reply }

class CommentTile extends StatefulWidget {
  final Map comment;
  final type;
  final parentID; //experienceID / rootCommentID
  const CommentTile(
      {super.key,
      required this.comment,
      required this.parentID,
      this.type = commentType.comment});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  @override
  Widget build(BuildContext context) {
    var userCommentData;
    return BlocConsumer<CommentBloc, CommentState>(
      listener: (context, state) {
        if (state is CommentInitial || state is SuccessLikedCommentState) {
          userCommentData =
              BlocProvider.of<CommentBloc>(context).getUserCommentData;
          ////
        }
        // TODO: implement listener
      },
      builder: (context, state) {
        return Column(
          children: [
            ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.only(left: 0, bottom: 0),
              leading: GestureDetector(
                onTap: () {
                  // TODO: Send to ProfilePage
                },
                child: CircleAvatar(
                    radius: 18,
                    child: Icon(Icons.person),
                    backgroundColor: Theme.of(context).listTileTheme.iconColor),
              ),
              title: commentTitle(context, userCommentData),
              isThreeLine: true,
              subtitle: commentContent(context, userCommentData),
            ),
          ],
        );
      },
    );
  }

  Column commentContent(BuildContext context, userCommentData) {
    return Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.comment['text'],
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodyText2)),
      SizedBox(height: 5),
      Align(
        alignment: Alignment.centerLeft,
        child: DefaultTextStyle.merge(
            style: Theme.of(context).textTheme.bodySmall,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    child: Text('${widget.comment['replies'].length} Replies'),
                    onTap: () {
                      // TODO: Show replies| send commentID of rootComment
                      BlocProvider.of<CommentBloc>(context).add(
                          ShowRepliesEvent(
                              commentID: widget.comment['commentID']));
                    }),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // TODO: REPLY | Send map of comment
                        BlocProvider.of<CommentBloc>(context).add(
                            WriteToCommentBoxEvent(
                                mainComment: widget.comment));
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(Icons.comment, size: 14),
                            ),
                            TextSpan(
                              text: ' Reply',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text('   '),
                    GestureDetector(
                      onTap: () {
                        // TODO: LIKE COMMENT| Send commentID
                        BlocProvider.of<CommentBloc>(context).add(
                            LikeCommentEvent(
                                commentID: widget.comment['likes']));
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            // TODO: LIKE COLOR|

                            WidgetSpan(
                                child: Icon(Icons.thumb_up,
                                    size: 14,
                                    color: userCommentData['likedComments']
                                            .contains(
                                                widget.comment['commentID'])
                                        ? Colors.red
                                        : null)),
                            TextSpan(text: ' ${widget.comment['likes']}'),
                          ],
                        ),
                      ),
                    ),
                    // If user is comment author:
                    userCommentData['experienceComments']
                            .contains(widget.comment['commentID'])
                        ? GestureDetector(
                            onTap: () {
                              // TODO: EDIT | TEST
                              BlocProvider.of<CommentBloc>(context).add(
                                  EditCommentEvent(
                                      commentID: widget.comment['commentID']));
                            },
                            child: Icon(Icons.edit, size: 10),
                          )
                        : Center(),
                    userCommentData['experienceComments']
                            .contains(widget.comment['commentID'])
                        ? GestureDetector(
                            onTap: () {
                              // TODO: DELETE | TEST
                              if (widget.type == commentType.comment) {
                                BlocProvider.of<CommentBloc>(context).add(
                                    DeleteCommentEvent(
                                        commentID: widget.comment['commentID'],
                                        experienceID: widget.parentID));
                              } else if (widget.type == commentType.reply) {
                                BlocProvider.of<CommentBloc>(context).add(
                                    DeleteReplyEvent(
                                        commentID: widget.comment['commentID'],
                                        rootCommentID: widget.parentID));
                              }
                            },
                            child: Icon(Icons.delete, size: 10),
                          )
                        : Center(),
                  ],
                ),
              ],
            )),
      ),
      SizedBox(height: 10)
    ]);
  }

  Row commentTitle(BuildContext context, userCommentData) {
    final duration = DateTime.now().difference(widget.comment['datePosted']);
    final timeDifference = DateTime.now().subtract(duration);
    final timeAgo = timeago.format(timeDifference, locale: 'en_short');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text('${widget.comment['username']}',
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                ))),
        SizedBox(width: 10),
        Container(
          width: MediaQuery.of(context).size.width * 0.1,
          child: DefaultTextStyle.merge(
              style: Theme.of(context).textTheme.bodySmall,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.circle, size: 5),
                  Text('  '),
                  Text('${timeAgo}'),
                  Text('   '),
                ],
              )),
        ),
      ],
    );
  }
}
