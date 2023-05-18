import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hikicomic/data/models/history_comic.dart';

class CardFollowingComic extends StatelessWidget {
  final HistoryComic comic;
  const CardFollowingComic({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        // context.pushNamed(
        //   "details",
        //   params: {"comicSEOAlias": comic.comicSEOAlias!},
        // )
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

                  errorWidget: (context, url, error) => Center(
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
                style: TextStyle(overflow: TextOverflow.ellipsis),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.remove_red_eye,
                    size: 10,
                  ),
                  Text(
                    comic.viewCount.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey.shade400),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.star,
                    size: 10,
                    color: Colors.yellow,
                  ),
                  Text(
                    comic.rating.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey.shade400),
                  )
                ],
              )
            ]),
      ),
    );
  }
}
