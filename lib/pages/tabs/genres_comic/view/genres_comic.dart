import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hikicomic/data/models/comic.dart';

import 'package:hikicomic/data/models/genre.dart';
import 'package:hikicomic/pages/tabs/genres_comic/bloc/genre_comic/genres_comic_bloc.dart';

import 'package:hikicomic/pages/tabs/genres_comic/bloc/list_genres_bloc/list_genres_bloc.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/widget/card_comic.dart';
import 'package:hikicomic/widget/loading_screen.dart';
import 'package:hikicomic/widget/snackbar.dart';
import 'package:shimmer/shimmer.dart';

class TabGenresComic extends StatefulWidget {
  const TabGenresComic({super.key});

  @override
  State<TabGenresComic> createState() => _TabGenresComicState();
}

class _TabGenresComicState extends State<TabGenresComic> {
  bool isShowMore = true;
  final scrollController = ScrollController();
  @override
  void initState() {
    // scollController.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ListGenresBloc()
            ..add(const LoadAllGenresEvent(indexSelectedGenre: 0)),
        ),
        BlocProvider(
          create: (context) => GenresComicBloc(),
        ),
      ],
      child: BlocConsumer<ListGenresBloc, ListGenresState>(
        listener: (context, state) {},
        buildWhen: (previous, current) {
          // if (previous is LoadListGenresSuccess &&
          //     current is LoadingListGenres) {
          //   return false;
          // }
          // List<Widget> list = new List<Widget>();

          return true;
        },
        builder: (context, state) {
          if (state is LoadingListGenres) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is LoadListGenresSuccess) {
            return BlocProvider(
              create: (context) => GenresComicBloc()
                ..add(LoadComicOfGenresEvent(
                    genre: state.listAllGenres[state.indexSelectedGenre])),
              child: CustomScrollView(
                controller: scrollController,
                slivers: [
                  SliverToBoxAdapter(
                      child: Wrap(
                          spacing: 5,
                          children: state.listAllGenres
                              .getRange(
                                  0,
                                  isShowMore == true
                                      ? 8
                                      : state.listAllGenres.length)
                              .map((e) => InkWell(
                                    onTap: () {
                                      print(e.genreName);
                                      context.read<ListGenresBloc>().add(
                                          LoadAllGenresEvent(
                                              indexSelectedGenre: state
                                                  .listAllGenres
                                                  .indexOf(e)));
                                      context.read<GenresComicBloc>().add(
                                          LoadComicOfGenresEvent(genre: e));
                                    },
                                    child: Chip(
                                      backgroundColor:
                                          state.indexSelectedGenre ==
                                                  state.listAllGenres.indexOf(e)
                                              ? kRed
                                              : null,
                                      label: Text(
                                        e.genreName!,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ),
                                  ))
                              .toList())),
                  SliverToBoxAdapter(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          isShowMore = !isShowMore;
                        });
                      },
                      child: Text(
                        isShowMore == true ? 'Show more' : 'Show less',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  BlocConsumer<GenresComicBloc, GenresComicState>(
                    listener: (context, state) {
                      // if (state is LoadingComicOfGenre) {
                      //   infoSnakBar(info: 'loading', duration: 10)
                      //       .show(context);
                      // }
                    },
                    buildWhen: (previous, current) {
                      return true;
                    },
                    builder: (context, state) {
                      if (state is LoadingComicOfGenre) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is LoadComicOfGenreFailure) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: Text(state.error),
                          ),
                        );
                      } else if (state is LoadComicOfGenreSuccess) {
                        return SliverGrid.builder(
                          gridDelegate:
                              SliverGridDelegateWithMaxCrossAxisExtent(
                                  // crossAxisCount: 3,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  maxCrossAxisExtent: 0.4.sw,
                                  mainAxisExtent: 0.25.sh),
                          itemCount: state.comicOfGenre.length,
                          itemBuilder: (context, index) =>
                              // Container(
                              //       child: Center(
                              //           child: Text(state.comicOfGenre[index].comicName!)),
                              //     )
                              CardComic(comic: state.comicOfGenre[index]),
                        );
                      }
                      return SliverToBoxAdapter();
                    },
                  )
                ],
              ),
            );
          }
          return SliverToBoxAdapter();
        },
      ),
      // SliverToBoxAdapter(child: BuildComicOfGenre(selectedGenre: ,
    );
  }
}

class BuildComicOfGenre extends StatefulWidget {
  final Genre selectedGenre;

  const BuildComicOfGenre({super.key, required this.selectedGenre});

  @override
  State<BuildComicOfGenre> createState() => _BuildComicOfGenreState();
}

class _BuildComicOfGenreState extends State<BuildComicOfGenre> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<GenresComicBloc>(
      create: (context) => GenresComicBloc()
        ..add(LoadComicOfGenresEvent(genre: widget.selectedGenre)),
      child: BlocConsumer<GenresComicBloc, GenresComicState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LoadingComicOfGenre) {
            return SliverToBoxAdapter(
              child: LoadingScreen(),
            );
          } else if (state is LoadComicOfGenreFailure) {
            return SliverToBoxAdapter(
              child: Center(
                child: Text(state.error),
              ),
            );
          } else if (state is LoadComicOfGenreSuccess) {
            return SliverGrid.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: state.comicOfGenre.length,
              itemBuilder: (context, index) =>
                  // Container(
                  //       child: Center(
                  //           child: Text(state.comicOfGenre[index].comicName!)),
                  //     )
                  CardComic(comic: state.comicOfGenre[index]),
            );
          }
          return SliverToBoxAdapter();
        },
      ),
    );
  }
}

// class BuildListGenres extends StatefulWidget {
//   const BuildListGenres({
//     super.key,
//     required this.listGenres,
//     required this.indexSelectedGenre,
//     // required this.isShowMore,
//   });
//   final List<Genre> listGenres;
//   final int indexSelectedGenre;
//   // final bool isShowMore;

//   @override
//   State<BuildListGenres> createState() => _BuildListGenresState();
// }

// class _BuildListGenresState extends State<BuildListGenres> {
//   late bool isShowMore;
//   @override
//   void initState() {
//     isShowMore = true;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Column(children: [
//             BuildGenres(
//                 listAllGenres: widget.listGenres,
//                 indexSelectedGenre: widget.indexSelectedGenre)
//             // Wrap(
//             //   children: buildGenres(state.listAllGenres,
//             //       context, state.indexSelectefGenre),
//             // ),

//             // BlocConsumer<GenresComicBloc, GenresComicState>(
//             //   listener: (context, state) {},
//             //   builder: (context, state) {
//             //     if (state is LoadListGenresSuccess) {

//             //     }
//             //     return Shimmer.fromColors(
//             //         baseColor: Colors.grey.shade300,
//             //         highlightColor: Colors.grey.shade100,
//             //         child: Wrap(
//             //             children: List.generate(
//             //           10,
//             //           (index) => Chip(label: Text("Genre")),
//             //         )));
//             //   },
//             // ),
//           ]),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         InkWell(
//             onTap: () {
//               setState(() {
//                 isShowMore = !isShowMore;
//               });
//             },
//             child: Text(isShowMore == true ? "Show more" : "Show less")),
//       ],
//     );
//   }
// }

class BuildGenres extends StatefulWidget {
  final List<Genre> listAllGenres;
  final int indexSelectedGenre;
  const BuildGenres(
      {super.key,
      required this.listAllGenres,
      required this.indexSelectedGenre});

  @override
  State<BuildGenres> createState() => _BuildGenresState();
}

class _BuildGenresState extends State<BuildGenres> {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: widget.listAllGenres
          .map((e) => BlocConsumer<GenresComicBloc, GenresComicState>(
                listener: (context, state) {},
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: InkWell(
                      onTap: () {
                        print(e.genreName);
                        context
                            .read<GenresComicBloc>()
                            .add(LoadComicOfGenresEvent(genre: e));
                      },
                      child: Chip(
                        backgroundColor: widget.indexSelectedGenre ==
                                widget.listAllGenres.indexOf(e)
                            ? kRed
                            : null,
                        label: Text(
                          e.genreName!,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  );
                },
              ))
          .toList(),
    );
  }
}

// List<Widget> buildGenres(
//     List<Genre> genres, BuildContext context, int selectedGenreIndex) {
//   List<Widget> listGenres = [];
//   for (var genre in genres) {
//     listGenres.add(BlocConsumer<GenresComicBloc, GenresComicState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         return InkWell(
//           onTap: () {
//             context
//                 .read<GenresComicBloc>()
//                 .add(LoadComicOfGenresEvent(genre: genre));
//           },
//           child: Chip(
//             backgroundColor:
//                 selectedGenreIndex == genres.indexOf(genre) ? kRed : null,
//             label: Text(
//               genre.genreName!,
//               style: Theme.of(context).textTheme.bodyMedium,
//             ),
//           ),
//         );
//       },
//     ));
//     listGenres.add(const SizedBox(
//       width: 10,
//     ));
//   }
//   return listGenres;
// }
