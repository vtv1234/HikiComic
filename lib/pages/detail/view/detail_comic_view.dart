// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hikicomic/data/models/comic.dart';
import 'package:hikicomic/data/models/genre.dart';
import 'package:hikicomic/pages/home/view/widgets/button_icon.dart';
import 'package:hikicomic/widget/popup_login.dart';

class ComicDetailView extends StatefulWidget {
  const ComicDetailView({
    Key? key,
  }) : super(key: key);

  @override
  State<ComicDetailView> createState() => _ComicDetailViewState();
}

class _ComicDetailViewState extends State<ComicDetailView> {
  Comic comic = Comic(
      comicId: 4,
      comicName: "OnePiece",
      alternative:
          "lorema fjakjfnkasfmasmf sdalfmsd gkjsdkl g asfnlsdlklsdmvnkdsnbnasmflnvfkjblkszdnbvnSDKJnbvkjnsxklnv ;dfnbkSDnvlorema fjakjfnkasfmasmf sdalfmsd gkjsdkl g asfnlsdlklsdmvnkdsnbnasmflnvfkjblkszdnbvnSDKJnbvkjnsxklnv ;dfnbkSDnvlorema fjakjfnkasfmasmf sdalfmsd gkjsdkl g asfnlsdlklsdmvnkdsnbnasmflnvfkjblkszdnbvnSDKJnbvkjnsxklnv ;dfnbkSDnvlorema fjakjfnkasfmasmf sdalfmsd gkjsdkl g asfnlsdlklsdmvnkdsnbnasmflnvfkjblkszdnbvnSDKJnbvkjnsxklnv ;dfnbkSDnvlorema fjakjfnkasfmasmf sdalfmsd gkjsdkl g asfnlsdlklsdmvnkdsnbnasmflnvfkjblkszdnbvnSDKJnbvkjnsxklnv ;dfnbkSDnvlorema fjakjfnkasfmasmf sdalfmsd gkjsdkl g asfnlsdlklsdmvnkdsnbnasmflnvfkjblkszdnbvnSDKJnbvkjnsxklnv ;dfnbkSDnv",
      comicCoverImageURL:
          'https://kunmanga.com/wp-content/uploads/2023/02/I-Became-The-Male-Leads-Female-Friend-kun-350x476.jpg');
  bool isReadmore = false;

  List<Genre> listGenres = [
    Genre(genreName: "Action"),
    Genre(genreName: "Romance"),
    Genre(genreName: "C"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
            titleSpacing: 0,
            pinned: true,
            actions: [
              IconButton(
                icon: Icon(Icons.monetization_on_outlined),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => loginDialog,
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.home_outlined),
                onPressed: () {},
              ),
            ],
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
                Text(
                  'One Piece',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          Theme.of(context).textTheme.bodyLarge?.fontSize),
                ),
              ],
            )),
        SliverToBoxAdapter(
          child: CachedNetworkImage(
            imageUrl: comic.comicCoverImageURL!,
            fit: BoxFit.fitWidth,
            height: 0.3.sh,
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comic.comicName!,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  'Eiichiro Oda',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                Wrap(
                  direction: Axis.horizontal,
                  children: [
                    Icon(Icons.thumb_up_outlined),
                    Text('5K'),
                    Icon(Icons.remove_red_eye_outlined),
                    Text('100K Views')
                  ],
                ),
                buildSummary(comic.alternative!),
                InkWell(
                  onTap: () {
                    setState(() {
                      isReadmore = !isReadmore;
                    });
                  },
                  child: Row(
                    children: [
                      Text(
                        (isReadmore ? 'Read Less' : 'Read More'),
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.grey),
                      ),
                      Icon(Icons.arrow_forward_ios_outlined)
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text('Genres'),
                    Wrap(children: buildGenres(listGenres)),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)))),
                          onPressed: () {},
                          icon: Text('Epsisode 1'),
                          label: Icon(Icons.arrow_forward_ios_outlined),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.red)))),
                          onPressed: () {},
                          icon: Text('Follow'),
                          label: Icon(Icons.add),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.lock_outline),
                    Text('Get the entire collection now'),
                    TextButton.icon(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(100.0),
                                      side: BorderSide(color: Colors.yellow)))),
                      onPressed: () {},
                      icon: Text(
                        'Unlock All',
                        style: TextStyle(fontSize: 10, color: Colors.yellow),
                      ),
                      label: Icon(Icons.arrow_forward_ios_outlined,
                          color: Colors.yellow),
                    ),
                    Spacer(),
                    IconButton(onPressed: () {}, icon: Icon(Icons.sort))
                  ],
                )
              ],
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: 10,
          (context, index) => Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                CachedNetworkImage(
                  imageUrl: comic.comicCoverImageURL!,
                  width: 0.3.sw,
                ),
                Column(
                  children: [Text('Episode 1'), Text('January')],
                ),
                Spacer(),
                Chip(label: Text('Free'))
              ],
            ),
          ),
        )),
      ],
    ));
  }

  List<Widget> buildGenres(List<Genre>? genres) {
    List<Widget> listGenres = <Widget>[];
    genres?.forEach((element) {
      //var tag;
      listGenres.add(
        InkResponse(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
              child: Chip(
                shape: const StadiumBorder(side: BorderSide()),
                backgroundColor: Colors.transparent,

                //backgroundColor: element.name!.color().backgroundColor,
                label: Text(
                  element.genreName!,
                ),
              ),
            )),
      );
    });
    return listGenres;
  }

  Widget buildSummary(String text) {
    final lines = isReadmore ? null : 3;
    return Text(
      text,
      //style: TextStyle(fontSize: ),
      maxLines: lines,
      overflow: isReadmore ? TextOverflow.visible : TextOverflow.ellipsis,
    );
  }
}
