import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hikicomic/data/models/comic.dart';

class ItemComic extends StatelessWidget {
  final Comic comic;

  ItemComic(this.comic);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl: comic.comicCoverImageURL!,

            // height: double.infinity,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,

                  // colorFilter: const ColorFilter.mode(
                  //   Colors.red,
                  //   BlendMode.colorBurn,
                  // ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
