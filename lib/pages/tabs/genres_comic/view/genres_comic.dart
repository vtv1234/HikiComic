import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:hikicomic/data/models/genre.dart';
import 'package:hikicomic/pages/tabs/genres_comic/bloc/genre_comic/genres_comic_bloc.dart';

import 'package:hikicomic/pages/tabs/genres_comic/bloc/list_genres_bloc/list_genres_bloc.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/widget/card_comic.dart';
import 'package:shimmer/shimmer.dart';

class TabGenresComic extends StatefulWidget {
  const TabGenresComic({super.key});

  @override
  State<TabGenresComic> createState() => _TabGenresComicState();
}

class _TabGenresComicState extends State<TabGenresComic> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListGenresBloc()
        ..add(const LoadAllGenresEvent(indexSelectedGenre: 0)),
      child: SingleChildScrollView(
        child: BlocConsumer<ListGenresBloc, ListGenresState>(
          listener: (context, state) {},
          // buildWhen: (previous, current) =>
          // previous != current && current is LoadComicOfGenreSuccess,
          builder: (context, state) {
            if (state is LoadListGenresSuccess) {
              return BlocProvider(
                create: (context) => GenresComicBloc()
                  ..add(LoadComicOfGenresEvent(
                      genre: state.listAllGenres[state.indexSelectedGenre])),
                child: Column(children: [
                  SizedBox(
                      height: 0.1.sh,
                      child: Scrollbar(
                          controller: ScrollController(),
                          child: SingleChildScrollView(
                              child: Column(children: [
                            BuildGenres(
                                listAllGenres: state.listAllGenres,
                                indexSelectedGenre: state.indexSelectedGenre)
                            // Wrap(
                            //   children: buildGenres(state.listAllGenres,
                            //       context, state.indexSelectefGenre),
                            // ),

                            // BlocConsumer<GenresComicBloc, GenresComicState>(
                            //   listener: (context, state) {},
                            //   builder: (context, state) {
                            //     if (state is LoadListGenresSuccess) {

                            //     }
                            //     return Shimmer.fromColors(
                            //         baseColor: Colors.grey.shade300,
                            //         highlightColor: Colors.grey.shade100,
                            //         child: Wrap(
                            //             children: List.generate(
                            //           10,
                            //           (index) => Chip(label: Text("Genre")),
                            //         )));
                            //   },
                            // ),
                          ])))),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 0.8.sh,
                    child: BlocConsumer<GenresComicBloc, GenresComicState>(
                      // bloc: GenresComicBloc()
                      //   ..add(LoadComicOfGenresEvent(
                      //       genre: state.listAllGenres[0])),
                      listener: (context, state) {
                        // if (state is LoadComicOfGenreSuccess) {}
                      },
                      builder: (context, state) {
                        if (state is LoadComicOfGenreSuccess) {
                          return RefreshIndicator(
                            onRefresh: () async {
                              // context.read<OngoingComicBloc>().add(LoadOngoingComicEvent());
                            },
                            child: AlignedGridView.count(
                                itemCount: state.comicOfGenre.length,
                                crossAxisCount: 3,
                                mainAxisSpacing: 6,
                                crossAxisSpacing: 6,
                                itemBuilder: (context, index) => CardComic(
                                      comic: state.comicOfGenre[index],
                                    )),
                          );
                        }
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          child: AlignedGridView.count(
                              itemCount: 20,
                              crossAxisCount: 3,
                              mainAxisSpacing: 6,
                              crossAxisSpacing: 6,
                              itemBuilder: (context, index) => Card(
                                    elevation: 1.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: SizedBox(height: 0.2.sh),
                                  )),
                        );
<<<<<<< Updated upstream
                      },
                    ),
=======
                      } else if (state is LoadComicOfGenreFailure) {
                        return SliverFillRemaining(
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
>>>>>>> Stashed changes
                  )
                ]),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
            // return Column(children: [
            //   Container(
            //     height: 0.1.sh,
            //     child: Scrollbar(
            //       child: SingleChildScrollView(
            //         child: Column(children: [
            //           BlocConsumer<GenresComicBloc, GenresComicState>(
            //             listener: (context, state) {},
            //             builder: (context, state) {
            //               if (state is LoadListGenresSuccess) {
            //                 return Wrap(
            //                   children:
            //                       buildGenres(state.listAllGenres, context),
            //                 );
            //               }
            //               return Shimmer.fromColors(
            //                   baseColor: Colors.grey.shade300,
            //                   highlightColor: Colors.grey.shade100,
            //                   child: Wrap(
            //                       children: List.generate(
            //                     10,
            //                     (index) => Chip(label: Text("Genre")),
            //                   )));
            //             },
            //           ),
            //           BlocConsumer<GenresComicBloc, GenresComicState>(
            //             listener: (context, state) {},
            //             builder: (context, state) {
            //               if (state is LoadListGenresSuccess) {
            //                 return Wrap(
            //                   children:
            //                       buildGenres(state.listAllGenres, context),
            //                 );
            //               }
            //               return Shimmer.fromColors(
            //                   baseColor: Colors.grey.shade300,
            //                   highlightColor: Colors.grey.shade100,
            //                   child: Wrap(
            //                       children: List.generate(
            //                     10,
            //                     (index) => Chip(label: Text("Genre")),
            //                   )));
            //             },
            //           )
            //         ]),
            //       ),
            //     ),
            //   )
            // ]);
          },
        ),
      ),
    );
  }
}

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
                        // setState(() {});
                        context.read<ListGenresBloc>().add(LoadAllGenresEvent(
                            indexSelectedGenre:
                                widget.listAllGenres.indexOf(e)));
                        context.read<GenresComicBloc>().add(
                            LoadComicOfGenresEvent(
                                genre: widget
                                    .listAllGenres[widget.indexSelectedGenre]));
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

List<Widget> buildGenres(
    List<Genre> genres, BuildContext context, int selectedGenreIndex) {
  List<Widget> listGenres = [];
  for (var genre in genres) {
    listGenres.add(BlocConsumer<GenresComicBloc, GenresComicState>(
      listener: (context, state) {},
      builder: (context, state) {
        return InkWell(
          onTap: () {
            context
                .read<GenresComicBloc>()
                .add(LoadComicOfGenresEvent(genre: genre));
          },
          child: Chip(
            backgroundColor:
                selectedGenreIndex == genres.indexOf(genre) ? kRed : null,
            label: Text(
              genre.genreName!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        );
      },
    ));
    listGenres.add(const SizedBox(
      width: 10,
    ));
  }
  return listGenres;
}
