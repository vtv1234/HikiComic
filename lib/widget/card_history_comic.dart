import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:hikicomic/data/models/history_comic.dart';
import 'package:hikicomic/utils/colors.dart';

class CardHistoryComic extends StatelessWidget {
  final HistoryComic comic;
  const CardHistoryComic({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {
    String dateRead = "";
    Duration differentDuration = DateTime.now().difference(comic.dateRead!);
    //second<minute<hours<day
    //60<60<24<1
    if (differentDuration > const Duration(days: 1)) {
      dateRead = '${differentDuration.inDays} day ago';
    } else if (differentDuration > const Duration(hours: 1)) {
      dateRead = '${differentDuration.inHours} hours ago';
    } else if (differentDuration > const Duration(minutes: 1)) {
      dateRead = '${differentDuration.inMinutes} minutes ago';
    } else {
      dateRead = '${differentDuration.inSeconds} seconds ago';
    }

    return GestureDetector(
      onTap: () => {
        // path: '/read-comic/:comicSEOAlias/:chapterSEOAlias',
        context.pushNamed('read-comic', params: {
          'comicSEOAlias': comic.comicSEOAlias!,
          'chapterSEOAlias': comic.chapterSEOAlias!
        })
      },
      //
      child: SizedBox(
        height: 0.3.sh,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  height: 0.20.sh,

                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.error),
                  ),
                  imageUrl: comic.comicCoverImageURL!,
                  // imageUrl:
                  //     "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8bmF0dXJhbHxlbnwwfHwwfHw%3D&w=1000&q=80",
                  fit: BoxFit.fitHeight,
                ),
              ),
              Text(
                comic.comicName!,
                maxLines: 1,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                comic.chapterName!,
                // style: Theme,
              ),
              Text(
                dateRead,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: kGrey),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   children: [
              //     Icon(
              //       Icons.remove_red_eye,
              //       size: 10,
              //     ),
              //     Text(
              //       comic.viewCount.toString(),
              //       style: Theme.of(context)
              //           .textTheme
              //           .bodySmall
              //           ?.copyWith(color: Colors.grey.shade400),
              //     ),
              //     SizedBox(
              //       width: 10,
              //     ),
              //     Icon(
              //       Icons.star,
              //       size: 10,
              //       color: Colors.yellow,
              //     ),
              //     Text(
              //       comic.rating.toString(),
              //       style: Theme.of(context)
              //           .textTheme
              //           .bodySmall
              //           ?.copyWith(color: Colors.grey.shade400),
              //     )
              //   ],
              // )
            ]),
      ),
    );
  }
}
