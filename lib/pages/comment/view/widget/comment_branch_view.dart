import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hikicomic/data/models/comment.dart';
import 'package:hikicomic/pages/comment/bloc/comment_bloc.dart';
import 'package:hikicomic/pages/sign_in/view/sign_in_view.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/utils/img_path.dart';
import 'package:hikicomic/utils/utils.dart';

class CommentBranchView extends StatefulWidget {
  final Comment comment;
  const CommentBranchView({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  State<CommentBranchView> createState() => _CommentBranchViewState();
}

class _CommentBranchViewState extends State<CommentBranchView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildComment(
          comment: widget.comment,
        ),
        widget.comment.childComments != null
            ? Column(
                children: widget.comment.childComments!
                    .map((e) => BuildComment(
                          comment: e,
                          commentParentUsername: widget.comment.userName,
                        ))
                    .toList()
                // ..add(BuildComment(comment: comment)),
                )
            : Container(),
        // Visibility(visible: isReply, child: BuildReplyComment())
      ],
    );
  }
}

class BuildComment extends StatefulWidget {
  final Comment comment;
  // final bool isReplyComment;
  final String? commentParentUsername;

  const BuildComment(
      {super.key, required this.comment, this.commentParentUsername});

  @override
  State<BuildComment> createState() => _BuildCommentState();
}

class _BuildCommentState extends State<BuildComment> {
  late bool isReplyComment;
  TextEditingController replyCommentController = TextEditingController();
  Utils utils = Utils();
  late String replyUsername;
  @override
  void initState() {
    isReplyComment = false;
    replyUsername = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: widget.comment.parentCommentId != null ? 40 : 0, bottom: 15),
      child: Column(
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 40,
                    width: 40,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child:
                          // state.accountInformation.userImageURL != null
                          //     ?
                          widget.comment.urlImageUser != "default.jpg"
                              ? CachedNetworkImage(
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  imageUrl: widget.comment.urlImageUser!)
                              : Image.asset(ImagePath.userAvatarImagePath),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                    flex: 8,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade800.withOpacity(0.1),
                              // border: Border.all(width: 1.0),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              )),
                          // height: 0.1.sh,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(
                                              text: widget.comment.userName!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: widget.comment
                                                                  .parentCommentId !=
                                                              null
                                                          ? Colors.white
                                                          : Colors.white)

                                              // children: [
                                              //   TextSpan(
                                              //     text: " - ",
                                              //     style: Theme.of(context)
                                              //         .textTheme
                                              //         .bodySmall,
                                              //   ),
                                              //   TextSpan(
                                              //     text: comment.stringDateCreated,
                                              //     style: Theme.of(context)
                                              //         .textTheme
                                              //         .bodySmall,
                                              //   )
                                              // ]
                                              ),
                                        ),
                                      ),

                                      // RichText(
                                      //   text: TextSpan(
                                      //       // text: comment.userName!,
                                      //       // style: Theme.of(context)
                                      //       //     .textTheme
                                      //       //     .headlineSmall
                                      //       //     ?.copyWith(
                                      //       //         overflow:
                                      //       //             TextOverflow.ellipsis),
                                      //       children: [
                                      //         TextSpan(
                                      //           text: " - ",
                                      //           style: Theme.of(context)
                                      //               .textTheme
                                      //               .bodySmall,
                                      //         ),
                                      //         TextSpan(
                                      //           text: comment.stringDateCreated,
                                      //           style: Theme.of(context)
                                      //               .textTheme
                                      //               .bodySmall,
                                      //         )
                                      //       ]),
                                      // ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      // commentParentUsername != null
                                      //     ? Transform.rotate(
                                      //         angle: 180 * pi / 180,
                                      //         child: Icon(Icons.reply))
                                      //     : Container(),
                                      Flexible(
                                        child: RichText(
                                          text: TextSpan(

                                              // text: commentParentUsername,
                                              // style: Theme.of(context)
                                              //     .textTheme
                                              //     .bodySmall
                                              //     ?.copyWith(
                                              //         color:
                                              //             comment.parentCommentId !=
                                              //                     null
                                              //                 ? Colors.green
                                              //                 : Colors.yellow),
                                              children: [
                                                WidgetSpan(
                                                    alignment:
                                                        PlaceholderAlignment
                                                            .bottom,
                                                    child: Transform.rotate(
                                                        angle: 180 * pi / 180,
                                                        child: Icon(
                                                          Icons.reply,
                                                          size:
                                                              widget.commentParentUsername !=
                                                                      null
                                                                  ? 14
                                                                  : 0,
                                                        ))),
                                                // : WidgetSpan(
                                                //     baseline: TextBaseline
                                                //         .ideographic,
                                                //     alignment:
                                                //         PlaceholderAlignment
                                                //             .top,
                                                //     child: Container(
                                                //       transform: Matrix4
                                                //           .translationValues(
                                                //               -10, -10, 0),
                                                //     )),
                                                TextSpan(
                                                    text: widget
                                                        .commentParentUsername,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color: widget
                                                                        .comment
                                                                        .parentCommentId !=
                                                                    null
                                                                ? Colors.white
                                                                : Colors
                                                                    .white)),
                                                TextSpan(
                                                    text:
                                                        ' ${widget.comment.commentContent}',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyMedium
                                                        ?.copyWith(
                                                            color:
                                                                Colors.white))
                                              ]),
                                        ),
                                      ),
                                    ],
                                  )
                                  // child: Text(comment.commentContent!)),
                                ]),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              utils.differentTime(widget.comment.dateCreated!),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 12, color: Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Like',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 12, color: Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Dislike',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontSize: 12, color: Colors.grey),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                                onTap: () {
                                  // context.read<CommentBloc>().add(ReplyComment(
                                  //     parentCommentId:
                                  //         widget.comment.commentId!,
                                  //     parentUsername:
                                  //         widget.comment.userName!));
                                  setState(() {
                                    replyUsername =
                                        'Reply to ${widget.comment.userName}';
                                    isReplyComment = !isReplyComment;
                                  });
                                },
                                child: Text(
                                  'Reply',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(
                                          fontSize: 12, color: Colors.grey),
                                )),
                          ],
                        )
                      ],
                    )),
              ]),
          Visibility(
            visible: isReplyComment,
            // maintainSize: true, //NEW
            // maintainAnimation: true, //NEW
            // maintainState: true,
            child: Padding(
              padding: const EdgeInsets.only(left: 40, top: 5, bottom: 10),
              child: Container(
                decoration: const BoxDecoration(
                  color: kWhite,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        textInputAction: TextInputAction.go,
                        onFieldSubmitted: (value) async {
                          if (replyCommentController.text.trim() != "") {
                            if (await utils.isLoggedIn()) {
                              if (mounted) {
                                context.read<CommentBloc>().add(SendComment(
                                    chapterId: widget.comment.chapterId,
                                    comicId: widget.comment.comicId!,
                                    commentContent: replyCommentController.text,
                                    parentCommentId:
                                        widget.comment.parentCommentId ??
                                            widget.comment.commentId));
                                setState(() {
                                  isReplyComment = !isReplyComment;
                                });
                              }
                            } else {
                              if (mounted) {
                                showDialog(
                                  context: context,
                                  builder: (context) => const SignInDialog(),
                                );
                              }
                            }
                          }
                        },
                        controller: replyCommentController,
                        cursorColor: kRed,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.black),
                        decoration: InputDecoration(
                            hintText: replyUsername,
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.grey.shade500),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.fromLTRB(
                                kDefaultPadding, 0, kDefaultPadding, 0)),
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          if (replyCommentController.text.trim() != "") {
                            if (await utils.isLoggedIn()) {
                              if (mounted) {
                                context.read<CommentBloc>().add(SendComment(
                                    chapterId: widget.comment.chapterId,
                                    comicId: widget.comment.comicId!,
                                    commentContent: replyCommentController.text,
                                    parentCommentId:
                                        widget.comment.parentCommentId ??
                                            widget.comment.commentId));
                                setState(() {
                                  isReplyComment = !isReplyComment;
                                });
                              }
                            } else {
                              if (mounted) {
                                showDialog(
                                  context: context,
                                  builder: (context) => const SignInDialog(),
                                );
                              }
                            }
                          }
                        },
                        icon: const Icon(
                          Icons.send,
                          color: kRed,
                        ))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
