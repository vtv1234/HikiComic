import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hikicomic/data/models/comic.dart';
import 'package:hikicomic/pages/tabs/ongoing_comic/bloc/ongoing_comic_bloc.dart';
import 'package:hikicomic/widget/card_comic.dart';

class TabOngoingComic extends StatefulWidget {
  const TabOngoingComic({super.key});

  @override
  State<TabOngoingComic> createState() => _TabOngoingComicState();
}

class _TabOngoingComicState extends State<TabOngoingComic> {
  final OngoingComicBloc _ongoingComicBloc = OngoingComicBloc();
  @override
  void initState() {
    _ongoingComicBloc.add(LoadOngoingComicEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OngoingComicBloc>(
      create: (context) => _ongoingComicBloc,
      child: BlocListener<OngoingComicBloc, OngoingComicState>(
          listener: (context, state) {
        if (state is OngoingComicError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
            ),
          );
        }
      }, child: BlocBuilder<OngoingComicBloc, OngoingComicState>(
        builder: (context, state) {
          if (state is OngoingComicInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is OngoingComicLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is OngoingComicError) {
            return Center(child: Text(state.error));
          }
          if (state is OngoingComicLoaded) {
            List<Comic> ongoingComics = state.ongoingComics;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<OngoingComicBloc>().add(LoadOngoingComicEvent());
              },
              child: AlignedGridView.count(
                  itemCount: ongoingComics.length,
                  crossAxisCount: 3,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  itemBuilder: (context, index) => CardComic(
                        comic: ongoingComics[index],
                      )),
            );
          }
          return Container();
        },
      )),
    );
  }
}
