import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hikicomic/pages/comment/bloc/comment_bloc.dart';
import 'package:hikicomic/pages/comment/view/widget/comment_branch_view.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/utils/utils.dart';
import 'package:hikicomic/widget/loading_screen.dart';

import 'package:intl/intl.dart' as intl;

import 'package:hikicomic/data/models/artist.dart';
import 'package:hikicomic/data/models/author.dart';
import 'package:hikicomic/data/models/chapter.dart';
import 'package:hikicomic/data/models/comic_detail.dart';
import 'package:hikicomic/data/models/genre.dart';
import 'package:hikicomic/pages/comic_detail/bloc/comic_detail_bloc.dart';
import 'package:hikicomic/pages/sign_in/view/sign_in_view.dart';
import 'package:hikicomic/repository/chapter_repository.dart';
import 'package:hikicomic/repository/comic_detail_repository.dart';

import 'package:hikicomic/widget/snackbar.dart';

class ComicDetailView extends StatefulWidget {
  final String comicSEOAlias;

  const ComicDetailView({
    Key? key,
    required this.comicSEOAlias,
  }) : super(key: key);

  @override
  State<ComicDetailView> createState() => _ComicDetailViewState();
}

class _ComicDetailViewState extends State<ComicDetailView> {
  final utils = Utils();

  @override
  Widget build(BuildContext context) {
    TextEditingController commentController = TextEditingController();
    DateTime lastPressedAt = DateTime.now();
    bool isEnable = true;

    return BlocProvider(
      create: (BuildContext context) =>
          ComicDetailBloc(ComicDetailRepository(), ChapterRepository()),
      child: Scaffold(
          body: BlocConsumer<ComicDetailBloc, ComicDetailState>(
              listener: (context, state) {
                if (state is UpdateStatusFollowingComicSuccessful) {
                  successSnakBar(success: state.message, duration: 2)
                      .show(context);
                  context
                      .read<ComicDetailBloc>()
                      .add(LoadComicDetailEvent(widget.comicSEOAlias));
                }
                if (state is UpdateStatusFollowingComicFailure) {
                  errorSnakBar(error: state.message, duration: 2).show(context);
                  // context
                  //     .read<ComicDetailBloc>()
                  //     .add(LoadComicDetailEvent(comicSEOAlias));
                }
                if (state is RatingComicSuccessful) {
                  successSnakBar(success: state.message, duration: 2)
                      .show(context);
                  context
                      .read<ComicDetailBloc>()
                      .add(LoadComicDetailEvent(widget.comicSEOAlias));
                }
                if (state is RatingComicFailure) {
                  infoSnakBar(info: state.message, duration: 10).show(context);
                  context
                      .read<ComicDetailBloc>()
                      .add(LoadComicDetailEvent(widget.comicSEOAlias));
                  showDialog(
                    context: context,
                    builder: (context) => const SignInDialog(),
                  );
                  // context
                  //     .read<ComicDetailBloc>()
                  //     .add(LoadComicDetailEvent(comicSEOAlias));
                }
              },
              buildWhen: (previous, current) =>
                  previous != current && current is LoadedComicDetailState ||
                  current is RatingComicFailure,
              builder: (context, state) {
                if (state is LoadingComicDetailState) {
                  context
                      .read<ComicDetailBloc>()
                      .add(LoadComicDetailEvent(widget.comicSEOAlias));
                  return const LoadingScreen();
                }
                if (state is ErrorComicDetailState) {
                  return const Center(child: Text("Error"));
                }
                if (state is LoadedComicDetailState) {
                  ComicDetail comicDetail = state.comicDetail;
                  List<Chapter> chapters = state.chapters;
                  return CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        SliverAppBar(
                            titleSpacing: 0,
                            pinned: true,
                            automaticallyImplyLeading: false,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => context.pop(),
                                  icon: const Icon(
                                    Icons.arrow_back_ios,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    comicDetail.comicName!,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: Colors.white,
                                        overflow: TextOverflow.ellipsis,
                                        fontSize: Theme.of(context)
                                            .textTheme
                                            .titleLarge
                                            ?.fontSize),
                                  ),
                                ),
                                // Spacer(),
                                // IconButton(
                                //   icon: const Icon(
                                //       Icons.monetization_on_outlined),
                                //   onPressed: () async {
                                //     // utils.deleteAllSecureData();
                                //     if (await utils.methodLogin() != "") {
                                //       print('methodLogin');

                                //       context.pushNamed(
                                //         'payment',
                                //       );
                                //     } else {
                                //       // infoSnakBar(info: 'no logged in',).show(context);
                                //       // prin
                                //       showDialog(
                                //         context: context,
                                //         builder: (context) => SignInDialog(),
                                //       );
                                //     }
                                //   },
                                // ),
                                IconButton(
                                  icon: const Icon(Icons.home_outlined),
                                  onPressed: () {
                                    context.pushNamed('home');
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(builder: (context) {
                                    //     return HomeScreen();
                                    //   }),
                                    // );
                                  },
                                ),
                              ],
                            )),
                        SliverToBoxAdapter(
                          child: CachedNetworkImage(
                            imageUrl: comicDetail.comicCoverImageURL!,
                            fit: BoxFit.fitWidth,
                            height: 0.3.sh,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comicDetail.comicName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: kSmallIconSize,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(comicDetail.viewCount.toString()),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow.shade700,
                                      size: kSmallIconSize,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(comicDetail.countRating.toString()),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.bookmark,
                                      color: Colors.red.shade400,
                                      size: kSmallIconSize,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(comicDetail.countFollow.toString()),
                                  ],
                                ),
                                Row(
                                  children: [
                                    RatingBar.builder(
                                      glowColor: kPrimary,
                                      initialRating:
                                          comicDetail.rating!.toDouble(),
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      //itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                                      itemSize: 25,
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),

                                      onRatingUpdate: (rating) async {
                                        // if (await utils.methodLogin() ==
                                        //     "true") {
                                        context.read<ComicDetailBloc>().add(
                                            RatingComicEvent(
                                                comicId: comicDetail.comicId!,
                                                comicSEOAlias:
                                                    widget.comicSEOAlias,
                                                rating: rating));
                                      },
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      comicDetail.rating.toString(),
                                      style:
                                          Theme.of(context).textTheme.bodySmall,
                                    )
                                  ],
                                ),
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text('Alternative',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                      ),
                                      // SizedBox(
                                      //   width: 5,
                                      // ),
                                      Expanded(
                                        flex: 7,
                                        child: Text(comicDetail.alternative!,
                                            maxLines: 5,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.copyWith(
                                                  color: Colors.grey,
                                                )),
                                      )
                                    ]),
                                BuildAuthor(authors: comicDetail.authors),
                                BuildArtist(
                                  artists: comicDetail.artists,
                                ),

                                Row(
                                  children: [
                                    const Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Genres',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 7,
                                      child: Wrap(
                                          direction: Axis.horizontal,
                                          spacing:
                                              8.0, // gap between adjacent chips
                                          runSpacing: 4.0,
                                          children: buildGenres(
                                              context, comicDetail.genres)),
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Summary',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),

                                BuildSummary(
                                  summary: comicDetail.summary!,
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
                                                  MaterialStateProperty.all(
                                                      kButtonBackground),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: const BorderSide(
                                                          color:
                                                              kButtonBackground)))),
                                          onPressed: () {
                                            context.pushNamed(
                                              "read-comic",
                                              params: {
                                                "comicSEOAlias":
                                                    comicDetail.comicSEOAlias!,
                                                'chapterSEOAlias':
                                                    chapters[0].chapterSEOAlias!
                                              },
                                            );
                                          },
                                          icon: Text(
                                            state.chapters[0].chapterName!,
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          label: const Icon(
                                            Icons.arrow_forward_ios_outlined,
                                            color: kWhite,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton.icon(
                                          style: ButtonStyle(

                                              // splashFactory: ,
                                              //  overlayColor: ,
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      kButtonBackground),
                                              shape: MaterialStateProperty.all<
                                                      RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              18.0),
                                                      side: const BorderSide(
                                                          color:
                                                              kButtonBackground)))),
                                          onPressed: () async {
                                            if (await utils.methodLogin() !=
                                                "") {
                                              if (isEnable) {
                                                if (mounted) {
                                                  context
                                                      .read<ComicDetailBloc>()
                                                      .add(
                                                          UpdateStatusFollowingComic(
                                                              comicDetail
                                                                  .comicId!));
                                                  isEnable = false;
                                                }
                                              } else if (DateTime.now()
                                                      .difference(
                                                          lastPressedAt) >=
                                                  const Duration(seconds: 10)) {
                                                if (mounted) {
                                                  context
                                                      .read<ComicDetailBloc>()
                                                      .add(
                                                          UpdateStatusFollowingComic(
                                                              comicDetail
                                                                  .comicId!));
                                                  lastPressedAt =
                                                      DateTime.now();
                                                }
                                              }
                                              // if (DateTime.now()
                                              //         .difference(lastPressedAt)
                                              //         .inSeconds !=
                                              //     0)
                                              else {
                                                if (mounted) {
                                                  infoSnakBar(
                                                          info:
                                                              "You can ${comicDetail.isFollow! ? 'unfollow' : 'follow'} this comic in ${10 - DateTime.now().difference(lastPressedAt).inSeconds} second",
                                                          duration: 2)
                                                      .show(context);
                                                }
                                              }
                                            } else {
                                              if (mounted) {
                                                infoSnakBar(
                                                        info:
                                                            "You must sign in to follow this comic",
                                                        duration: 10)
                                                    .show(context);
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      const SignInDialog(),
                                                ).then((value) => context
                                                    .read<ComicDetailBloc>()
                                                    .add(LoadComicDetailEvent(
                                                        widget.comicSEOAlias)));
                                              }
                                            }
                                          },
                                          icon: AnimatedSwitcher(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              transitionBuilder: (Widget child,
                                                  Animation<double> animation) {
                                                return
                                                    // RotationTransition(
                                                    //     turns: animation);
                                                    ScaleTransition(
                                                        scale: animation,
                                                        child: child);
                                              },
                                              child: Text(
                                                comicDetail.isFollow!
                                                    ? 'Following'
                                                    : 'Follow',
                                                key: ValueKey(
                                                    comicDetail.isFollow!),
                                              )
                                              // comicDetail.isFollow!
                                              //     ? Icons.check
                                              //     : Icons.add,
                                              // color: kWhite,
                                              // size: 16,
                                              ),
                                          label: AnimatedSwitcher(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              transitionBuilder: (Widget child,
                                                  Animation<double> animation) {
                                                return
                                                    // RotationTransition(
                                                    //     turns: animation);
                                                    ScaleTransition(
                                                        scale: animation,
                                                        child: child);
                                              },
                                              child: Icon(
                                                comicDetail.isFollow!
                                                    ? Icons.check
                                                    : Icons.add,
                                                key: ValueKey(
                                                    comicDetail.isFollow!),
                                              )
                                              // comicDetail.isFollow!
                                              //     ? Icons.check
                                              //     : Icons.add,
                                              // color: kWhite,
                                              // size: 16,
                                              ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                // Row(
                                //   children: [
                                //     const Icon(
                                //       Icons.lock_outline,
                                //       size: kSmallIconSize,
                                //       color: kYellow,
                                //     ),
                                //     Text('Get the entire collection now',
                                //         maxLines: 2,
                                //         style: Theme.of(context)
                                //             .textTheme
                                //             .bodySmall),
                                //     const SizedBox(
                                //       width: 10,
                                //     ),
                                //     ElevatedButton(
                                //       style: darkTheme(context)
                                //           .elevatedButtonTheme
                                //           .style
                                //           ?.copyWith(
                                //               // iconSize:
                                //               //     MaterialStatePropertyAll(),
                                //               padding:
                                //                   const MaterialStatePropertyAll(
                                //                       EdgeInsets.all(
                                //                           kDefaultPadding)),
                                //               iconColor:
                                //                   const MaterialStatePropertyAll(
                                //                       kYellow),
                                //               foregroundColor:
                                //                   MaterialStateProperty.all(
                                //                       kYellow),
                                //               side: MaterialStateProperty
                                //                   .resolveWith((states) =>
                                //                       const BorderSide(
                                //                           color: kYellow))),
                                //       child: Row(children: [
                                //         Text("unlock all",
                                //             style: Theme.of(context)
                                //                 .textTheme
                                //                 .bodySmall
                                //                 ?.copyWith(color: kYellow)
                                //             //style: TextStyle(color: kYellow),
                                //             ),
                                //         const Icon(
                                //           Icons.arrow_forward_ios_outlined,
                                //           size: kSmallIconSize,
                                //         )
                                //       ]),
                                //       onPressed: () {},
                                //     ),
                                //     const Spacer(),
                                //     IconButton(
                                //         splashRadius: 25,
                                //         onPressed: () {},
                                //         icon: const Icon(Icons.sort)),
                                //   ],
                                // )
                              ]
                                  .map((widget) => Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 5, 5, 0),
                                        child: widget,
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Chapters',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.bold)),
                        )),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              if (index.isOdd) {
                                return const Divider(
                                    indent: 8,
                                    endIndent: 8,
                                    height: 0,
                                    color: Colors.grey);
                              }
                              return InkWell(
                                onTap: () =>
                                    // chapters[index ~/ 2].isLockedChapter!
                                    //     ? showDialog(
                                    //         context: context,
                                    //         builder: (context) => SignInDialog(
                                    //             // userRepository: UserRepository(),
                                    //             ),
                                    //       )
                                    //     :
                                    context.pushNamed(
                                  "read-comic",
                                  params: {
                                    "comicSEOAlias": comicDetail.comicSEOAlias!,
                                    'chapterSEOAlias':
                                        chapters[index ~/ 2].chapterSEOAlias!
                                  },
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    // mainAxisAl,
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          chapters[index ~/ 2].chapterName!,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      //const Spacer(),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          intl.DateFormat('MM-dd-yyyy').format(
                                              chapters[index ~/ 2]
                                                  .dateCreated!),
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),

                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          chapters[index ~/ 2]
                                              .viewCount
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                      ),

                                      // Expanded(
                                      //     flex: 2,
                                      //     child: Chip(
                                      //         padding: const EdgeInsets.all(0),
                                      //         label: Row(
                                      //           mainAxisAlignment:
                                      //               MainAxisAlignment.center,
                                      //           children: [
                                      //             chapters[index ~/ 2]
                                      //                     .isLockedChapter!
                                      //                 ? const Icon(
                                      //                     Icons.lock,
                                      //                     color: kYellow,
                                      //                     size: kSmallIconSize,
                                      //                   )
                                      //                 : Container(),
                                      //             const SizedBox(
                                      //               width: 2,
                                      //             ),
                                      //             Text(
                                      //               chapters[index ~/ 2]
                                      //                       .isLockedChapter!
                                      //                   ? 'Read'
                                      //                   : 'Free',
                                      //               style: Theme.of(context)
                                      //                   .textTheme
                                      //                   .bodySmall
                                      //                   ?.copyWith(
                                      //                       color: chapters[
                                      //                                   index ~/
                                      //                                       2]
                                      //                               .isLockedChapter!
                                      //                           ? kYellow
                                      //                           : kWhite),
                                      //             ),
                                      //           ],
                                      //         )))
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount: (state.chapters.length * 2) - 1,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: BlocProvider(
                              create: (context) => CommentBloc()
                                ..add(GetListCommentOfChapter(
                                    comicDetail.comicId!, null)),
                              child: BlocConsumer<CommentBloc, CommentState>(
                                listener: (context, state) {
                                  if (state is SendedCommentFail) {
                                    errorSnakBar(
                                            error: state.error, duration: 10)
                                        .show(context);
                                  }
                                  if (state is SendedCommentSuccess) {
                                    commentController.text = "";
                                    context.read<CommentBloc>().add(
                                        GetListCommentOfChapter(
                                            comicDetail.comicId!, null));
                                  }
                                },
                                builder: (context, state) {
                                  if (state is CommentLoading) {
                                    return const LoadingScreen();
                                  }

                                  if (state is CommentLoadedSuccessful) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Divider(
                                            thickness: 0,
                                            indent: 0,
                                            height: 20,
                                            color: Colors.white,
                                          ),
                                          Text('Comments',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.bold)),
                                          ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  state.listComment!.length,
                                              itemBuilder: (context, index) =>
                                                  CommentBranchView(
                                                      comment: state
                                                          .listComment![index])

                                              // itemCount: 5,
                                              // itemBuilder: (context, index) => ParentCommentView(),
                                              ),
                                          Container(
                                            decoration: const BoxDecoration(
                                              color: kWhite,
                                              // borderRadius: BorderRadius.only(
                                              //     topLeft: Radius.circular(
                                              //         kBorderRadius),
                                              //     topRight: Radius.circular(
                                              //         kBorderRadius)),
                                            ),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        commentController,
                                                    cursorColor: kRed,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall
                                                        ?.copyWith(
                                                            color:
                                                                Colors.black),
                                                    decoration: const InputDecoration(
                                                        contentPadding:
                                                            EdgeInsets.fromLTRB(
                                                                kDefaultPadding,
                                                                0,
                                                                kDefaultPadding,
                                                                0)),
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () async {
                                                      if (commentController.text
                                                              .trim() !=
                                                          "") {
                                                        if (await utils
                                                                .methodLogin() !=
                                                            "") {
                                                          if (mounted) {
                                                            context
                                                                .read<
                                                                    CommentBloc>()
                                                                .add(SendComment(
                                                                    chapterId:
                                                                        null,
                                                                    comicId:
                                                                        comicDetail
                                                                            .comicId!,
                                                                    commentContent:
                                                                        commentController
                                                                            .text,
                                                                    parrentCommentId:
                                                                        null));
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
                                        ],
                                      ),
                                    );
                                  }
                                  return const LoadingScreen();
                                },
                              )),
                        ),
                      ]);

                  // return AlignedGridView.count(
                  //     itemCount: hotComics.length,
                  //     crossAxisCount: 3,
                  //     mainAxisSpacing: 6,
                  //     crossAxisSpacing: 6,
                  //     itemBuilder: (context, index) => CardComic(
                  //           comic: hotComics[index],
                  //         ));
                }
                return Container();
              })),
    );
  }

  List<Widget> buildGenres(BuildContext context, List<Genre>? genres) {
    List<Widget> listGenres = <Widget>[];
    genres?.forEach((element) {
      listGenres.add(InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            context.pushNamed('comic-genre',
                params: {'genre': (element.genreId! - 2).toString()});
          },
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: kWhite, width: 0.5),
                borderRadius:
                    const BorderRadius.all(Radius.circular(kBorderRadius))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              child: Text(
                element.genreName!,
                style: const TextStyle(color: Colors.grey),
              ),
            ),
          )));
    });
    return listGenres;
  }
}

// class BuildAlternative extends StatelessWidget{
//   final List<String> alternatives;

//   const BuildAlternative({super.key, required this.alternatives});
//   @override
//   Widget build(BuildContext context) {
//     List<Widget> listAuthor = <Widget>[];
//     for (int i = 0; i < alternatives.length; i++) {
//       if (i != 0) listAuthor.add(Text(', '));
//       listAuthor.add(Text(alternatives[i].al!));
//     }
//     return Row(
//       children: listAuthor,
//     );

//   }
// }

class BuildSummary extends StatefulWidget {
  final String summary;

  const BuildSummary({super.key, required this.summary});

  @override
  State<BuildSummary> createState() => _BuildSummaryState();
}

class _BuildSummaryState extends State<BuildSummary> {
  late bool isReadMore;
  String visibleControl = "";
  late int countLine;

  // _BuildSummaryState(this.summary);

  // bool hasTextOverflow(String text,
  //     // TextStyle style,
  //     {double minWidth = 0,
  //     double maxWidth = double.infinity,
  //     int maxLines = 3}) {
  //   final TextPainter textPainter = TextPainter(
  //     text: TextSpan(
  //       text: text,
  //       // style: style
  //     ),
  //     maxLines: maxLines,
  //     textDirection: TextDirection.,
  //   )..layout(minWidth: minWidth, maxWidth: maxWidth);
  //   return textPainter.didExceedMaxLines;
  // }

  @override
  void initState() {
    isReadMore = false;
    // countLines = '\n'.allMatches(widget.summary).length + 1;
    // if (countLines > 3) {
    //   visibleControl = "Read More";
    // }
    //  else {
    //   visibleControl = "Read More";
    // }

    // else if(countLines>3)
    // if (hasTextOverflow(widget.summary)) {
    //   isReadMore = true;
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final lines = isReadMore ? null : 3;
    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final span = TextSpan(
                text: widget.summary,
                style: Theme.of(context).textTheme.displaySmall);
            final tp =
                TextPainter(text: span, textDirection: TextDirection.ltr);
            tp.layout(
              maxWidth: constraints.maxWidth,
            );
            final numLines = tp.computeLineMetrics().length;

            if (numLines > 3) {
              // SchedulerBinding.instance.scheduleFrameCallback((timeStamp) {
              //   setState(() {
              //     countLine;
              //   });
              // });

              // print(numLines);
              return Column(
                children: [
                  Text(
                    widget.summary,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.grey.shade400),
                    maxLines: lines,
                    overflow: isReadMore
                        ? TextOverflow.visible
                        : TextOverflow.ellipsis,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        // if (hasTextOverflow(
                        //   widget.summary,
                        // )) {
                        isReadMore = !isReadMore;
                        if (isReadMore == true) {
                          visibleControl = "Read less";
                        }
                        // }
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          isReadMore ? "Read less" : "Read more",
                          // (
                          //   countLines>3 ?:null: 'Read More' : 'Read Less'),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(color: Colors.grey),
                        ),
                        Icon(
                          isReadMore
                              ? Icons.arrow_back_ios_outlined
                              : Icons.arrow_forward_ios_outlined,
                          size: 13,
                        )
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  Text(
                    widget.summary,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.grey.shade400),
                    maxLines: 3,
                    // overflow: isReadMore
                    //     ? TextOverflow.visible
                    //     : TextOverflow.ellipsis,
                  ),
                  //           InkWell(
                  //   onTap: () {
                  //     setState(() {
                  //       // if (hasTextOverflow(
                  //       //   widget.summary,
                  //       // )) {
                  //       isReadMore = !isReadMore;
                  //       visibleControl = "Read less";
                  //       // }
                  //     });
                  //   },
                  //   child: Row(
                  //     children: [
                  //       Text(
                  //         visibleControl,
                  //         // (
                  //         //   countLines>3 ?:null: 'Read More' : 'Read Less'),
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .labelLarge
                  //             ?.copyWith(color: Colors.grey),
                  //       ),
                  //       const Icon(
                  //         Icons.arrow_forward_ios_outlined,
                  //         size: 13,
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              );
            }
          },
        ),

        // Text(
        //   widget.summary,
        //   textAlign: TextAlign.justify,
        //   style: TextStyle(color: Colors.grey.shade400),
        //   maxLines: lines,
        //   overflow: isReadMore ? TextOverflow.visible : TextOverflow.ellipsis,
        // ),
      ],
    );
  }
}

class BuildAuthor extends StatelessWidget {
  final List<Author> authors;

  const BuildAuthor({super.key, required this.authors});

  @override
  Widget build(BuildContext context) {
    List<Widget> listAuthor = <Widget>[];
    for (int i = 0; i < authors.length; i++) {
      if (i != 0) listAuthor.add(const Text(', '));

      // listAuthor.add(SizedBox(
      //   width: 32,
      // ));

      listAuthor.add(Text(
        authors[i].authorName!,
        style: TextStyle(color: Colors.grey.shade400),
      ));
    }
    return Row(children: [
      const Expanded(
        flex: 2,
        child: Text(
          'Author',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        flex: 7,
        child: Row(
          children: listAuthor,
        ),
      )
    ]);
  }
}

class BuildArtist extends StatelessWidget {
  final List<Artist> artists;

  const BuildArtist({super.key, required this.artists});

  @override
  Widget build(BuildContext context) {
    List<Widget> listArtist = <Widget>[];
    for (int i = 0; i < artists.length; i++) {
      if (i != 0) listArtist.add(const Text(', '));

      // listArtist.add(SizedBox(
      //   width: 32,
      // ));

      listArtist.add(Text(
        artists[i].artistName!,
        style: TextStyle(color: Colors.grey.shade400),
      ));
    }
    return Row(children: [
      const Expanded(
        flex: 2,
        child: Text(
          'Artist',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Expanded(
        flex: 7,
        child: Row(
          children: listArtist,
        ),
      )
    ]);
  }
}
