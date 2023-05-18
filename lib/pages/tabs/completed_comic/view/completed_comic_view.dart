import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:hikicomic/data/models/comic.dart';

import 'package:hikicomic/pages/tabs/completed_comic/bloc/completed_comic_bloc.dart';
import 'package:hikicomic/repository/comic_repository.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/widget/card_comic.dart';

class TabCompletedComic extends StatelessWidget {
  const TabCompletedComic({super.key});

  @override
  Widget build(BuildContext context) {
    int pageIndex = 1;
    int pageSize = 30;
    return BlocProvider(
      create: (BuildContext context) => CompletedComicBloc()
        ..add(
            LoadCompletedComicEvent(pageIndex: pageIndex, pageSize: pageSize)),
      child: BlocBuilder<CompletedComicBloc, CompletedComicState>(
        builder: (context, state) {
          if (state is CompletedComicLoadingState) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: RefreshIndicator(
                onRefresh: () async {
                  context.read<CompletedComicBloc>().add(
                      LoadCompletedComicEvent(
                          pageIndex: pageIndex, pageSize: pageSize));
                },
                child: Container(
                    height: 0.8.sh,
                    child: Center(child: CircularProgressIndicator())),
              ),
            );
          }
          if (state is CompletedComicErrorState) {
            return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: RefreshIndicator(
                  onRefresh: () async {
                    context.read<CompletedComicBloc>().add(
                        LoadCompletedComicEvent(
                            pageIndex: pageIndex, pageSize: pageSize));
                  },
                  child:
                      // Container(alignment: Alignment.center,child: AutoSizeText.rich(
                      //   TextSpan(text: )
                      // ),)
                      Container(
                          height: 0.8.sh,
                          child: Center(child: Text(state.error))),
                ));
          }
          if (state is CompletedComicLoadedState) {
            List<Comic> hotComics = state.CompletedComics;
            return RefreshIndicator(
              color: kWhite,
              onRefresh: () async {
                context.read<CompletedComicBloc>().add(LoadCompletedComicEvent(
                    pageIndex: pageIndex, pageSize: pageSize));
              },
              child: state.CompletedComics.isEmpty
                  ? Center(
                      child: Text("There's no completed comic"),
                    )
                  : AlignedGridView.count(
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
    );
  }
}
