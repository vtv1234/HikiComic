// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hikicomic/data/models/comment.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/utils/img_path.dart';

class CommentBranchView extends StatelessWidget {
  final Comment comment;
  const CommentBranchView({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BuildComment(comment: comment),
        comment.childComments != null
            ? Column(
                children: comment.childComments!
                    .map((e) => BuildComment(comment: e))
                    .toList(),
              )
            : Container()
      ],
    );
  }
}

class BuildComment extends StatelessWidget {
  final Comment comment;

  const BuildComment({super.key, required this.comment});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.only(
        left: comment.parentCommentId != null ? 40 : 0,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: 0.1.sh,
        ),

        // height: 0.2.sh,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: 30,
                  width: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child:
                        // state.accountInformation.userImageURL != null
                        //     ?
                        comment.urlImageUser != null
                            ? CachedNetworkImage(
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                                fit: BoxFit.cover,
                                imageUrl: comment.urlImageUser!)
                            : Image.asset(ImagePath.userAvatarImagePath),
                  ),
                ),
              ),
              Expanded(
                  flex: 10,
                  child: Container(
                    decoration: BoxDecoration(
                        color: kGrey.shade700,
                        // border: Border.all(width: 1.0),
                        borderRadius: BorderRadius.all(
                          Radius.circular(kBorderRadius),
                        )),
                    // height: 0.1.sh,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 8, left: 8, right: 8, bottom: 8),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              comment.userName!,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            Text(comment.commentContent!)
                          ]),
                    ),
                  ))
            ]),
      ),
    );
  }
}
