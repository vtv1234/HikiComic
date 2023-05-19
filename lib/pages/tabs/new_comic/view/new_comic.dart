import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:hikicomic/data/models/comic.dart';

import 'package:hikicomic/pages/tabs/new_comic/bloc/new_comic_bloc.dart';
import 'package:hikicomic/repository/comic_repository.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/widget/card_comic.dart';

class TabNewComic extends StatelessWidget {
  const TabNewComic({super.key});

  @override
  Widget build(BuildContext context) {
    int pageIndex = 1;
    int pageSize = 30;
    return BlocProvider(
      create: (context) => NewComicBloc(ComicRepository()),
      child: BlocProvider(
        create: (BuildContext context) => NewComicBloc(ComicRepository())
          ..add(LoadNewComicEvent(pageIndex: pageIndex, pageSize: pageSize)),
        child: BlocBuilder<NewComicBloc, NewComicState>(
          builder: (context, state) {
            if (state is NewComicLoadingState) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<NewComicBloc>().add(LoadNewComicEvent(
                        pageIndex: pageIndex, pageSize: pageSize));
                  },
                  child: SizedBox(
                      height: 0.8.sh,
                      child: const Center(child: CircularProgressIndicator())),
                ),
              );
            }
            if (state is NewComicErrorState) {
              return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<NewComicBloc>().add(LoadNewComicEvent(
                          pageIndex: pageIndex, pageSize: pageSize));
                    },
                    child: SizedBox(
                        height: 0.8.sh,
                        child: Center(child: Text(state.error))),
                  ));
            }
            if (state is NewComicLoadedState) {
              List<Comic> hotComics = state.newComics;
              return RefreshIndicator(
                color: kWhite,
                onRefresh: () async {
                  context.read<NewComicBloc>().add(LoadNewComicEvent(
                      pageIndex: pageIndex, pageSize: pageSize));
                },
                child: AlignedGridView.count(
                    itemCount: hotComics.length,
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    itemBuilder: (context, index) => CardComic(
                          comic: hotComics[index],
                        )),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}

class TabNewFeedComic extends StatelessWidget {
  const TabNewFeedComic({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('newfeed'));
  }
}
