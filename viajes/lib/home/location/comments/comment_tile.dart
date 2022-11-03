import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viajes/home/location/comments/bloc/comment_bloc.dart';

class CommentTile extends StatefulWidget {
  final String comment;
  const CommentTile({super.key, required this.comment});

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CommentBloc, CommentState>(
      listener: (context, state) {
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
              title: commentTitle(context),
              isThreeLine: true,
              subtitle: commentContent(context),
            ),
          ],
        );
      },
    );
  }

  Column commentContent(BuildContext context) {
    return Column(children: [
      Align(
          alignment: Alignment.centerLeft,
          child: Text(widget.comment,
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
                    child: Text('87 Replies'),
                    onTap: () {
                      // TODO: Show replies
                    }),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<CommentBloc>(context)
                            .add(WriteToCommentBoxEvent());
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
                    Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(child: Icon(Icons.thumb_up, size: 14)),
                          TextSpan(text: ' 122'),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
      ),
      SizedBox(height: 10)
    ]);
  }

  Row commentTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text('Username with a long username',
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
                  Text('8d'),
                  Text('   '),
                ],
              )),
        ),
      ],
    );
  }
}
