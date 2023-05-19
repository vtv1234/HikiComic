import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hikicomic/data/models/chapter_image.dart';
import 'package:hikicomic/pages/comment/view/comment_view.dart';
import 'package:hikicomic/pages/read_comic/bloc/read_comic_bloc.dart';

import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/widget/snackbar.dart';

class ReadComicView extends StatefulWidget {
  final String comicSEOAlias;
  final String chapterSEOAlias;
  const ReadComicView(
      {super.key, required this.comicSEOAlias, required this.chapterSEOAlias});

  @override
  State<ReadComicView> createState() => _ReadComicViewState();
}

class _ReadComicViewState extends State<ReadComicView>
    with TickerProviderStateMixin {
  late final ScrollListener _model;
  late final ScrollController _controller;
  final double _bottomNavBarHeight = 57;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _model = ScrollListener.initialise(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => ReadComicBloc()
            ..add(LoadChapterImageEvent(
                widget.comicSEOAlias, widget.chapterSEOAlias)),
          child: BlocConsumer<ReadComicBloc, ReadComicState>(
            listener: (context, state) async {
              if (state is ErrorChapterImageState) {
                // SchedulerBinding.instance.addPostFrameCallback(
                //     (timeStamp) async =>
                // await errorSnakBar(error: state.error, duration: 10)
                //     .show(context);
                // if (await utils.isLoggedIn() != "true") {
                //   SchedulerBinding.instance
                //       .addPostFrameCallback((timeStamp) async => showDialog(
                //             context: context,
                //             builder: (context) => SignInDialog(),
                //           ));
                // }
              }
            },
            buildWhen: (previous, current) =>
                previous != current && current is LoadedChapterImageState,
            builder: (context, state) {
              if (state is LoadingChapterImageState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is LoadedChapterImageState) {
                ChapterImage chapterImage = state.chapterImage;
                return AnimatedBuilder(
                  animation: _model,
                  builder: (context, child) => Stack(children: [
                    Scrollbar(
                      thickness: 5,
                      radius: const Radius.circular(25),
                      interactive: true,
                      trackVisibility: true,
                      thumbVisibility: true,
                      controller: _controller,
                      child: CustomScrollView(
                        physics: const BouncingScrollPhysics(),
                        controller: _controller,
                        slivers: [
                          SliverAppBar(
                            automaticallyImplyLeading: false,
                            floating: true,
                            titleSpacing: 0,
                            actions: [
                              IconButton(
                                  onPressed: () {
                                    context.pop();
                                  },
                                  icon: const Icon(Icons.home_outlined))
                            ],
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () => context.pop('refresh'),
                                  // goNamed(
                                  //   "details",
                                  //   params: {
                                  //     "comicSEOAlias": widget.comicSEOAlias
                                  //   },
                                  // ),
                                  icon: const Icon(Icons.arrow_back_ios,
                                      color: Colors.white),
                                ),
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(chapterImage.chapterName!),
                                      // Text(
                                      //   'A mother and her daughter',
                                      //   style: TextStyle(
                                      //       color: Colors.white,
                                      //       fontSize: Theme.of(context)
                                      //           .textTheme
                                      //           .bodySmall
                                      //           ?.fontSize),
                                      // )
                                    ]),
                              ],
                            ),
                          ),
                          SliverList(
                              key: ObjectKey(
                                chapterImage.chapterImageURLs![0],
                              ),
                              delegate: SliverChildBuilderDelegate(
                                  (context, index) => CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: chapterImage
                                            .chapterImageURLs![index],
                                        placeholder: (context, url) =>
                                            const SizedBox(
                                                height: 100,
                                                child: Center(
                                                    child:
                                                        CircularProgressIndicator())),
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                                child: Icon(Icons.error)),
                                      ),
                                  childCount:
                                      chapterImage.chapterImageURLs!.length))
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: _model.bottom,
                      child: SizedBox(
                        height: _bottomNavBarHeight,
                        child: BottomNavigationBar(
                          backgroundColor: Colors.black,
                          type: BottomNavigationBarType.fixed,
                          selectedItemColor: Colors.white,
                          unselectedItemColor: Colors.white,
                          showUnselectedLabels: true,
                          selectedFontSize: 12,
                          currentIndex: 0,
                          onTap: (value) {
                            switch (value) {
                              case 0:
                                if (chapterImage.previousChapterSEOAlias ==
                                    null) {
                                  infoSnakBar(
                                          info:
                                              "No previous chapter available ",
                                          duration: 10)
                                      .show(context);
                                } else {
                                  context.read<ReadComicBloc>().add(
                                      LoadChapterImageEvent(
                                          widget.comicSEOAlias,
                                          state.chapterImage
                                              .previousChapterSEOAlias!));
                                }
                                break;
                              case 2:
                                showModalBottomSheet(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(kBorderRadius),
                                  ),
                                  context: context,
                                  builder: (context) => CommentView(
                                      chapterId: state.chapterImage.chapterId!,
                                      comicId: state.chapterImage.comicId!,
                                      chapterName:
                                          state.chapterImage.chapterName!),
                                );
                                // if (chapterImage.previousChapterSEOAlias ==
                                //     null) {
                                //   infoSnakBar(
                                //           info:
                                //               "No previous chapter available ",
                                //           duration: 10)
                                //       .show(context);
                                // } else {
                                //   context.read<ReadComicBloc>().add(
                                //       LoadChapterImageEvent(
                                //           widget.comicSEOAlias,
                                //           state.chapterImage
                                //               .previousChapterSEOAlias!));
                                // }
                                break;

                              case 4:
                                context.read<ReadComicBloc>().add(
                                    LoadChapterImageEvent(
                                        widget.comicSEOAlias,
                                        state.chapterImage
                                            .nextChapterSEOAlias!));

                                break;
                              default:
                            }
                          },

                          //backgroundColor: Colors.amber,
                          items: const [
                            BottomNavigationBarItem(
                                icon: Icon(Icons.arrow_back_outlined),
                                label: 'Prev'),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.thumb_up_outlined),
                                label: 'Like'),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.comment_outlined),
                                label: 'Comment'),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.list), label: 'Chapter'),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.arrow_forward_outlined),
                                label: 'Next'),
                          ],
                        ),
                      ),
                    ),
                  ]),
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  // Widget get _bottomNavBar {
  //   return SizedBox(
  //     height: _bottomNavBarHeight,
  //     child: BottomNavigationBar(
  //       backgroundColor: Colors.black,
  //       type: BottomNavigationBarType.fixed,
  //       selectedItemColor: Colors.white,
  //       unselectedItemColor: Colors.white,
  //       showUnselectedLabels: true,
  //       selectedFontSize: 12,
  //       currentIndex: 0,
  //       onTap: (value) {
  //         switch (value) {
  //           case 4:
  //             context
  //                 .read<ReadComicBloc>()
  //                 .add(LoadChapterImageEvent(widget.comicSEOAlias, state));

  //             break;
  //           default:
  //         }
  //       },

  //       //backgroundColor: Colors.amber,
  //       items: [
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.arrow_back_outlined), label: 'Prev'),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.thumb_up_outlined), label: 'Like'),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.comment_outlined), label: 'Comment'),
  //         BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Chapter'),
  //         BottomNavigationBarItem(
  //             icon: Icon(Icons.arrow_forward_outlined), label: 'Next'),
  //       ],
  //     ),
  //   );
  // }
}

class ScrollListener extends ChangeNotifier {
  double bottom = 0;
  double _last = 0;

  ScrollListener.initialise(ScrollController controller, [double height = 57]) {
    controller.addListener(() {
      final current = controller.offset;
      bottom += _last - current;
      if (bottom <= -height) bottom = -height;
      if (bottom >= 0) bottom = 0;
      _last = current;
      if (bottom <= 0 && bottom >= -height) notifyListeners();
    });
  }
}
