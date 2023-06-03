import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:hikicomic/data/models/comic.dart';

import 'package:hikicomic/pages/tabs/ranking_comic/bloc/ranking_comic_bloc.dart';
import 'package:hikicomic/utils/colors.dart';

import 'package:hikicomic/widget/card_comic.dart';
import 'package:hikicomic/widget/loading_screen.dart';

class TabRankingComic extends StatelessWidget {
  const TabRankingComic({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RankingComicBloc>(
      create: (context) => RankingComicBloc()..add(LoadRankingComicEvent()),
      child: BlocBuilder<RankingComicBloc, RankingComicState>(
        builder: (context, state) {
          if (state is RankingComicLoadingState) {
            return LoadingScreen();
          }

          if (state is RankingComicErrorState) {
            return Center(child: Text(state.error));
          }
          if (state is RankingComicLoadedState) {
            List<Comic> rankingComics = state.rankingComics;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<RankingComicBloc>().add(LoadRankingComicEvent());
              },
              child: AlignedGridView.count(
                  itemCount: rankingComics.length,
                  crossAxisCount: 3,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  itemBuilder: (context, index) => SizedBox(
                        height: 0.24.sh,
                        child: Stack(children: [
                          CardComic(
                            comic: rankingComics[index],
                          ),
                          Positioned(
                              top: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: kRed,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(5),
                                      bottomRight: Radius.circular(5)),
                                ),
                                // color: kRed,
                                height: 20,
                                width: 20,
                                child:
                                    Center(child: Text((index + 1).toString())),
                              )),
                        ]),
                      )),
            );
          }
          return Container();
        },
      ),
    );
  }
}
