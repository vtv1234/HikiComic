import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:hikicomic/pages/library/bloc/following_comic_bloc/following_comic_bloc.dart';

import 'package:hikicomic/pages/library/bloc/recent_comic_bloc/recent_comic_bloc.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/widget/card_comic.dart';
import 'package:hikicomic/widget/card_history_comic.dart';
import 'package:shimmer/shimmer.dart';

class LibrarySceen extends StatelessWidget {
  const LibrarySceen({super.key});

//   @override
//   State<LibraryView> createState() => _LibraryViewState();
// }

// class _LibraryViewState extends State<LibraryView> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Library",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: kWhite),
          ),
          //foregroundColor: darkAppBarTheme.backgroundColor,
          elevation: 0,
          backgroundColor: kAppBarDark,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20,
                color: kWhite,
              )),
          // bottom: TabBar(
          //   indicator: BoxDecoration(
          //       color: kRed, borderRadius: BorderRadius.circular(25.0)),
          //   labelColor: Colors.white,
          //   unselectedLabelColor: Colors.black,
          //   tabs: myTabs,
          // ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TabBar(
                unselectedLabelColor: Colors.redAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    // gradient: LinearGradient(
                    //     colors: [Colors.redAccent, Colors.orangeAccent]),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent),
                tabs: const [Tab(text: 'Recent'), Tab(text: 'Following')],
              ),
              const SizedBox(
                height: 10,
              ),
              const Expanded(
                  child: TabBarView(
                children: [
                  RecentComicView(),
                  FollowingComicView(),
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class FollowingComicView extends StatelessWidget {
  const FollowingComicView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.8.sh,
      child: BlocProvider(
        create: (context) =>
            FollowingComicBloc()..add(LoadFollowingComicEvent()),
        child: BlocBuilder<FollowingComicBloc, FollowingComicState>(
          builder: (context, state) {
            if (state is FollowingComicLoaded) {
              // Center(
              //   child: Text('Loaded'),
              // );
              return AlignedGridView.count(
                  itemCount: state.followingComic.length,
                  crossAxisCount: 3,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  itemBuilder: (context, index) =>
                      CardComic(comic: state.followingComic[index]));
            }

            if (state is FollowingComicError) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is FollowingComicLoading) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: AlignedGridView.count(
                    itemCount: 12,
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    itemBuilder: (context, index) => Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SizedBox(height: 0.2.sh),
                        )
                    // Container(
                    //       height: 200,
                    //       width: 100,
                    //       color: Colors.red,
                    //     )

                    ),
              );
            }
            return Container(
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}

class RecentComicView extends StatelessWidget {
  const RecentComicView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.8.sh,
      child: BlocProvider(
        create: (context) => RecentComicBloc()..add(LoadRecentComicEvent()),
        child: BlocBuilder<RecentComicBloc, RecentComicState>(
          // listener: (context, state) {
          //   if (state is RecentComicLoaded) {
          //     Center(
          //       child: Text('Loaded'),
          //     );
          //     // Center(
          //     //     child: AlignedGridView.count(
          //     //         itemCount: state.recentComic.length,
          //     //         crossAxisCount: 3,
          //     //         mainAxisSpacing: 6,
          //     //         crossAxisSpacing: 6,
          //     //         itemBuilder: (context, index) => CardHistoryComic(
          //     //               comic: state.recentComic[index],
          //     //             )));
          //   }

          //   if (state is RecentComicError) {
          //     Center(
          //       child: Text(state.error),
          //     );
          //   }
          // },
          builder: (context, state) {
            if (state is RecentComicLoaded) {
              // Center(
              //   child: Text('Loaded'),
              // );
              return AlignedGridView.count(
                  itemCount: state.recentComic.length,
                  crossAxisCount: 3,
                  mainAxisSpacing: 6,
                  crossAxisSpacing: 6,
                  itemBuilder: (context, index) =>
                      CardHistoryComic(comic: state.recentComic[index]));
            }

            if (state is RecentComicError) {
              return Center(
                child: Text(state.error),
              );
            }
            if (state is RecentComicLoading) {
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade300,
                highlightColor: Colors.grey.shade100,
                child: AlignedGridView.count(
                    itemCount: 12,
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    itemBuilder: (context, index) => Card(
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: SizedBox(height: 0.2.sh),
                        )
                    // Container(
                    //       height: 200,
                    //       width: 100,
                    //       color: Colors.red,
                    //     )

                    ),
              );
            }
            return Container(
              color: Colors.red,
            );
          },
        ),
      ),
    );
  }
}
