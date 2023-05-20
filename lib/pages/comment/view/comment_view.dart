import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hikicomic/pages/comment/bloc/comment_bloc.dart';
import 'package:hikicomic/pages/comment/view/widget/comment_branch_view.dart';

import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/utils/utils.dart';
import 'package:hikicomic/widget/snackbar.dart';

import '../../sign_in/view/sign_in_view.dart';

class CommentView extends StatefulWidget {
  final int comicId;
  final int chapterId;
  final String chapterName;
  const CommentView(
      {super.key,
      required this.comicId,
      required this.chapterId,
      required this.chapterName});

  @override
  State<CommentView> createState() => _CommentViewState();
}

class _CommentViewState extends State<CommentView> {
  final TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Utils utils = Utils();
    return BlocProvider(
        create: (context) => CommentBloc()
          ..add(GetListCommentOfChapter(widget.comicId, widget.chapterId)),
        child: BlocConsumer<CommentBloc, CommentState>(
          listener: (context, state) {
            if (state is SendedCommentFail) {
              errorSnakBar(error: state.error, duration: 10).show(context);
            }
            if (state is SendedCommentSuccess) {
              commentController.text == "";
              context.read<CommentBloc>().add(
                  GetListCommentOfChapter(widget.comicId, widget.chapterId));
            }
          },
          builder: (context, state) {
            if (state is CommentLoadedSuccessful) {
              return Scaffold(
                  backgroundColor: Colors.transparent,
                  resizeToAvoidBottomInset: true,
                  bottomSheet: Container(
                    decoration: const BoxDecoration(
                      color: kWhite,
                      // borderRadius: BorderRadius.only(
                      //     topLeft: Radius.circular(kBorderRadius),
                      //     topRight: Radius.circular(kBorderRadius)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: commentController,
                            cursorColor: kRed,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: Colors.black),
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.fromLTRB(
                                    kDefaultPadding, 0, kDefaultPadding, 0)),
                          ),
                        ),
                        IconButton(
                            onPressed: () async {
                              if (commentController.text.trim() != "") {
                                if (await utils.isLoggedIn() == "true") {
                                  if (mounted) {
                                    context.read<CommentBloc>().add(SendComment(
                                        chapterId: widget.chapterId,
                                        comicId: widget.comicId,
                                        commentContent: commentController.text,
                                        parrentCommentId: null));
                                  }
                                } else {
                                  if (mounted) {
                                    showDialog(
                                      context: context,
                                      builder: (context) =>
                                          const SignInDialog(),
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
                  body: Container(
                    height: 0.6.sh,
                    decoration: const BoxDecoration(
                      color: Color(0x00242526),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(
                            widget.chapterName,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.listComment!.length,
                                itemBuilder: (context, index) =>
                                    CommentBranchView(
                                        comment: state.listComment![index])

                                // itemCount: 5,
                                // itemBuilder: (context, index) => ParentCommentView(),
                                ),
                          ),
                          // Expanded(
                          //     child: Align(
                          //         alignment: Alignment.bottomCenter,
                          //         child: Container(
                          //             height: 0.1.sh,
                          //             decoration: BoxDecoration(
                          //               color: kGrey.shade700,
                          //               border: Border.all(width: 3.0),
                          //               borderRadius: BorderRadius.all(
                          //                   Radius.circular(20)
                          //                   // bottomLeft:
                          //                   //     Radius.circular(kBorderRadius),
                          //                   // topRight: Radius.circular(kBorderRadius)),
                          //                   ),
                          //             ),
                          //             child: Row(
                          //               children: [TextFormField()],
                          //             ))))
                        ],
                      ),
                    ),
                  ));
            }
            return const Center(
              child: CircularProgressIndicator(
                color: kRed,
                strokeWidth: 2,
              ),
            );
          },
        ));
  }
}
