import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import 'package:hikicomic/pages/search/bloc/search_bloc.dart';
import 'package:hikicomic/utils/colors.dart';

class SearchView extends SearchDelegate<List?> {
  final SearchBloc searchBloc;

  SearchView(this.searchBloc)
      : super(
          searchFieldLabel: 'Search comic name',
        );
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const BackButtonIcon(),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    searchBloc.add(SearchEvent(query));
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchStateError) {
            return const Center(
              child: Text('Fail to search comics'),
            );
          } else if (state is SearchStateSuccess) {
            if (state.comics.isEmpty) {
              return const Center(
                child: Text('No result found'),
              );
            } else {
              if (query.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.fireFlameCurved,
                          color: Colors.orange,
                        ),
                        Text(
                          'Trending searches',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => InkResponse(
                        onTap: () => {
                          context.pushNamed(
                            "details",
                            params: {
                              "comicSEOAlias":
                                  state.hotComics[index].comicSEOAlias!
                            },
                          )
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          color: kPrimary,
                          elevation: 0,
                          // color: Colors.white,
                          //shape: const ShapeBorder(),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.fill,
                                        imageUrl: state.hotComics[index]
                                            .comicCoverImageURL!),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${index + 1}. ${state.hotComics[index].comicName!}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        // Text(
                                        //   'Alternative: ${state.hotComics[index].alternative!}',
                                        //   maxLines: 1,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        // Text(
                                        //   "Status: ${state.hotComics[index].status}",
                                        // ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            'View count: ${state.hotComics[index].viewCount}'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            'Rating: ${state.hotComics[index].rating!.toStringAsFixed(2)}/5'),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ))
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Total ',
                            style: Theme.of(context).textTheme.headlineSmall,
                            children: [
                          TextSpan(
                              text: state.comics.length.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: kRed))
                        ])),
                    const SizedBox(
                      height: kDefaultPadding,
                    ),
                    Expanded(
                      child: ListView.builder(
                          // separatorBuilder: (BuildContext context, int index) =>
                          //     const Divider(
                          //       color: kWhite,
                          //     ),
                          itemCount: state.comics.length,
                          itemBuilder: (context, index) => InkResponse(
                                onTap: () => {},
                                child: Card(
                                  margin: const EdgeInsets.only(
                                      bottom: kDefaultPadding),
                                  elevation: 0.1,
                                  // color: Colors.white,
                                  //shape: const ShapeBorder(),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 120,
                                          width: 80,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                fit: BoxFit.fill,
                                                imageUrl: state.comics[index]
                                                    .comicCoverImageURL!),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    state.comics[index]
                                                        .comicName!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Alternative: ${state.comics[index].alternative!}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Status: ${state.comics[index].status}",
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    'View count: ${state.comics[index].viewCount}'),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    'Rating: ${state.comics[index].rating!.toStringAsFixed(2)}/5'),
                                              ],
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                              )
                          // Row(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         ClipRRect(
                          //           borderRadius: BorderRadius.circular(5),
                          //           child: CachedNetworkImage(
                          //             height: 0.20.sh,
                          //             errorWidget: (context, url, error) => Center(
                          //               child: Icon(Icons.error),
                          //             ),
                          //             imageUrl: state.comics[index].comicCoverImageURL!,
                          //             fit: BoxFit.fitHeight,
                          //           ),
                          //         ),
                          //         Expanded(
                          //           child: Column(
                          //             mainAxisAlignment: MainAxisAlignment.start,
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: [
                          //               Text(state.comics[index].comicName!),
                          //               Text(state.comics[index].alternative!),
                          //               Spacer(),
                          //               Text(state.comics[index].rating.toString())
                          //             ],
                          //           ),
                          //         )
                          //       ],
                          //     )
                          ),
                    ),
                  ],
                );
              }
            }
          }
          return Container();

          // return ListView.builder(
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       leading: Icon(Icons.location_city),
          //       title: Text(state.comics![index].comicName!),
          //       onTap: () => close(context, state.comics![index]),
          //     );
          //   },
          //   itemCount: state.comics!.length,
          // );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    searchBloc.add(SearchEvent(query));
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: BlocBuilder<SearchBloc, SearchState>(
        builder: (context, state) {
          if (state is SearchStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SearchStateError) {
            return const Center(
              child: Text('Fail to search comics'),
            );
          } else if (state is SearchStateSuccess) {
            if (state.comics.isEmpty) {
              return const Center(
                child: Text('No result found'),
              );
            } else {
              if (query.isEmpty) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 10,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.fireFlameCurved,
                          color: Colors.orange,
                        ),
                        Text(
                          'Trending searches',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) => InkResponse(
                        onTap: () => {
                          context.pushNamed(
                            "details",
                            params: {
                              "comicSEOAlias":
                                  state.hotComics[index].comicSEOAlias!
                            },
                          )
                        },
                        child: Card(
                          margin: const EdgeInsets.only(bottom: 10),
                          color: kPrimary,
                          elevation: 0,
                          // color: Colors.white,
                          //shape: const ShapeBorder(),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 120,
                                  width: 80,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                        fit: BoxFit.fill,
                                        imageUrl: state.hotComics[index]
                                            .comicCoverImageURL!),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            "${index + 1}. ${state.hotComics[index].comicName!}",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headlineSmall),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        // Text(
                                        //   'Alternative: ${state.hotComics[index].alternative!}',
                                        //   maxLines: 1,
                                        //   overflow: TextOverflow.ellipsis,
                                        // ),
                                        // const SizedBox(
                                        //   height: 5,
                                        // ),
                                        // Text(
                                        //   "Status: ${state.hotComics[index].status}",
                                        // ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            'View count: ${state.hotComics[index].viewCount}'),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            'Rating: ${state.hotComics[index].rating!.toStringAsFixed(2)}/5'),
                                      ],
                                    ),
                                  ),
                                )
                              ]),
                        ),
                      ),
                    ))
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Total ',
                            style: Theme.of(context).textTheme.headlineSmall,
                            children: [
                          TextSpan(
                              text: state.comics.length.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(color: kRed))
                        ])),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: ListView.builder(
                          // separatorBuilder: (BuildContext context, int index) =>
                          //     const Divider(
                          //       color: kWhite,
                          //     ),
                          itemCount: state.comics.length,
                          itemBuilder: (context, index) => InkResponse(
                                onTap: () => {},
                                child: Card(
                                  margin: const EdgeInsets.only(
                                      bottom: kDefaultPadding),
                                  elevation: 0.1,
                                  // color: Colors.white,
                                  //shape: const ShapeBorder(),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 120,
                                          width: 80,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                                fit: BoxFit.fill,
                                                imageUrl: state.comics[index]
                                                    .comicCoverImageURL!),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    state.comics[index]
                                                        .comicName!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headlineSmall),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Alternative: ${state.comics[index].alternative!}',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Status: ${state.comics[index].status}",
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    'View count: ${state.comics[index].viewCount}'),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    'Rating: ${state.comics[index].rating!.toStringAsFixed(2)}/5'),
                                              ],
                                            ),
                                          ),
                                        )
                                      ]),
                                ),
                              )
                          // Row(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         ClipRRect(
                          //           borderRadius: BorderRadius.circular(5),
                          //           child: CachedNetworkImage(
                          //             height: 0.20.sh,
                          //             errorWidget: (context, url, error) => Center(
                          //               child: Icon(Icons.error),
                          //             ),
                          //             imageUrl: state.comics[index].comicCoverImageURL!,
                          //             fit: BoxFit.fitHeight,
                          //           ),
                          //         ),
                          //         Expanded(
                          //           child: Column(
                          //             mainAxisAlignment: MainAxisAlignment.start,
                          //             crossAxisAlignment: CrossAxisAlignment.start,
                          //             children: [
                          //               Text(state.comics[index].comicName!),
                          //               Text(state.comics[index].alternative!),
                          //               Spacer(),
                          //               Text(state.comics[index].rating.toString())
                          //             ],
                          //           ),
                          //         )
                          //       ],
                          //     )
                          ),
                    ),
                  ],
                );
              }
            }
          }
          return Container();

          // return ListView.builder(
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       leading: Icon(Icons.location_city),
          //       title: Text(state.comics![index].comicName!),
          //       onTap: () => close(context, state.comics![index]),
          //     );
          //   },
          //   itemCount: state.comics!.length,
          // );
        },
      ),
    );
  }
}
