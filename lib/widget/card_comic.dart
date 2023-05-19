import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hikicomic/data/models/comic.dart';

class CardComic extends StatelessWidget {
  final Comic comic;
  const CardComic({super.key, required this.comic});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        context.pushNamed(
          "details",
          params: {"comicSEOAlias": comic.comicSEOAlias!},
        )
      },
      //
      child: SizedBox(
        height: 0.26.sh,
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
                  fit: BoxFit.fitHeight,
                ),
              ),
              Text(
                comic.comicName!,
                maxLines: 1,
                style: const TextStyle(overflow: TextOverflow.ellipsis),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
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
                  const SizedBox(
                    width: 10,
                  ),
                  const Icon(
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
