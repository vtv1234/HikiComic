import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:hikicomic/pages/tabs/genres_comic/bloc/genre_comic/genres_comic_bloc.dart';
import 'package:hikicomic/pages/tabs/genres_comic/bloc/list_genres_bloc/list_genres_bloc.dart';
import 'package:hikicomic/pages/tabs/genres_comic/view/genres_comic.dart';
import 'package:hikicomic/widget/card_comic.dart';
import 'package:hikicomic/widget/loading_screen.dart';
import 'package:shimmer/shimmer.dart';

class ComicGenreView extends StatelessWidget {
  final String selectedGenre;

  const ComicGenreView({super.key, required this.selectedGenre});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListGenresBloc()
        ..add(LoadAllGenresEvent(indexSelectedGenre: int.parse(selectedGenre))),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: const Text('Genres')),
          body: SingleChildScrollView(
            child: BlocConsumer<ListGenresBloc, ListGenresState>(
              listener: (context, state) {},
              // buildWhen: (previous, current) =>
              // previous != current && current is LoadComicOfGenreSuccess,
              builder: (context, state) {
                if (state is LoadListGenresSuccess) {
                  return BlocProvider(
                    create: (context) => GenresComicBloc()
                      ..add(LoadComicOfGenresEvent(
                          genre:
                              state.listAllGenres[state.indexSelectedGenre])),
                    child: Column(children: [
                      SizedBox(
                          height: 0.1.sh,
                          child: Scrollbar(
                              controller: ScrollController(),
                              child: SingleChildScrollView(
                                  child: Column(children: [
                                BuildGenres(
                                    listAllGenres: state.listAllGenres,
                                    indexSelectedGenre:
                                        state.indexSelectedGenre)
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
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        child: SizedBox(height: 0.2.sh),
                                      )),
                            );
                          },
                        ),
                      )
                    ]),
                  );
                }
                return const LoadingScreen();
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
        ),
      ),
    );
  }
}
