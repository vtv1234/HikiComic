// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:hikicomic/pages/authentication/authentication.dart';
import 'package:hikicomic/pages/search/bloc/search_bloc.dart';
import 'package:hikicomic/pages/search/search_view.dart';
import 'package:hikicomic/pages/sign_in/view/sign_in_view.dart';
import 'package:hikicomic/pages/tabs/ranking_comic/view/ranking_comic_view.dart';
import 'package:hikicomic/repository/authentication_repository.dart';

import 'package:hikicomic/pages/home/bloc/home_bloc.dart';

import 'package:hikicomic/pages/tabs/genres_comic/view/genres_comic.dart';
import 'package:hikicomic/pages/tabs/new_comic/view/new_comic.dart';
import 'package:hikicomic/pages/tabs/ongoing_comic/view/ongoing_comic.dart';

import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/utils/img_path.dart';
import 'package:hikicomic/utils/utils.dart';
import 'package:hikicomic/widget/lazy_load_indexed_stack.dart';

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);

const actionColor = Color(0xFF5F5FA7);

final divider = Divider(color: kWhite.withOpacity(0.3), height: 1);

class HomeScreen extends StatefulWidget {
  // static const routeName = '/';

  // final ComicRepository _comicRepository = ComicRepository();
  static List<String> homeTab = [
    'Ongoing',
    'New',
    'Completed',
    'Ranking',
    'Genres',
    'Newsfeed',
  ];

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => HomeBloc(), child: HomeView());
  }
}

class BuildSideBar extends StatelessWidget {
  BuildSideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final utils = Utils();
    // return BlocBuilder<AuthenticationBloc, AuthenticationState>(
    //   builder: (context, state) {
    //     if (state.status == AuthenticationStatus.authenticated) {
    //       return Drawer(

    //         controller: SidebarXController(selectedIndex: 0, extended: true),
    //         theme: SidebarXTheme(
    //           margin: const EdgeInsets.all(10),
    //           decoration: BoxDecoration(
    //             color: kPrimary,
    //             borderRadius: BorderRadius.circular(20),
    //           ),
    //           textStyle: const TextStyle(color: Colors.white),
    //           selectedTextStyle: const TextStyle(color: Colors.white),
    //           itemTextPadding: const EdgeInsets.only(left: 30),
    //           selectedItemTextPadding: const EdgeInsets.only(left: 30),
    //           itemDecoration: BoxDecoration(
    //             border: Border.all(color: kPrimary),
    //           ),
    //           selectedItemDecoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(10),
    //             border: Border.all(
    //               color: actionColor.withOpacity(0.37),
    //             ),
    //             gradient: const LinearGradient(
    //               colors: [accentCanvasColor, canvasColor],
    //             ),
    //             boxShadow: [
    //               BoxShadow(
    //                 color: Colors.black.withOpacity(0.28),
    //                 blurRadius: 30,
    //               )
    //             ],
    //           ),
    //           iconTheme: const IconThemeData(
    //             color: Colors.white,
    //             size: 20,
    //           ),
    //         ),
    //         collapseIcon: Icons.arrow_forward_ios_outlined,
    //         extendIcon: Icons.arrow_back_ios_outlined,
    //         extendedTheme: const SidebarXTheme(
    //           width: 200,
    //           decoration: BoxDecoration(
    //             color: kPrimary,
    //           ),
    //           margin: EdgeInsets.only(right: 10),
    //         ),
    //         headerBuilder: (context, extended) {
    //           return SafeArea(
    //               child: InkWell(
    //             onTap: () {
    //               context.pushNamed('account');
    //             },
    //             child: Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: Column(
    //                 children: [
    //                   SizedBox(
    //                     height: extended ? 100 : null,
    //                     width: 100,
    //                     child: Padding(
    //                       padding: const EdgeInsets.all(0),
    //                       child: ClipRRect(
    //                         borderRadius: BorderRadius.circular(120),
    //                         child: state.user.userImageURL != null
    //                             ? CachedNetworkImage(
    //                                 errorWidget: (context, url, error) =>
    //                                     const Icon(Icons.error),
    //                                 fit: BoxFit.fill,
    //                                 placeholder: (context, url) => Center(
    //                                       child: CircularProgressIndicator(
    //                                         color: kRed,
    //                                         strokeWidth: 2,
    //                                       ),
    //                                     ),
    //                                 imageUrl: state.user.userImageURL!)
    //                             : Image.asset(ImagePath.userAvatarImagePath),
    //                       ),
    //                     ),
    //                   ),
    //                   extended
    //                       ? Text(
    //                           state.user.email!,
    //                           style: Theme.of(context).textTheme.headlineSmall,
    //                         )
    //                       : Container()
    //                 ],
    //               ),
    //             ),
    //           ));
    //         },
    //         items: [
    //           SidebarXItem(
    //             icon: Icons.home,
    //             label: 'Home',
    //             onTap: () {},
    //           ),
    //           const SidebarXItem(
    //             icon: Icons.search,
    //             label: 'Search',
    //           ),
    //           SidebarXItem(
    //             onTap: () async {
    //               if (await utils.isLoggedIn() == "true") {
    //                 // print('isLoggedIn');
    //                 context.pushNamed(
    //                   'library',
    //                 );
    //               } else {
    //                 // infoSnakBar(info: 'no logged in').show(context);
    //                 // prin
    //                 showDialog(
    //                   context: context,
    //                   builder: (context) => SignInDialog(),
    //                 );
    //               }
    //             },
    //             icon: Icons.book_outlined,
    //             label: 'Library',
    //           ),
    //           SidebarXItem(
    //             onTap: () => context
    //                 .read<AuthenticationBloc>()
    //                 .add(AuthenticationLogoutRequested()),
    //             icon: Icons.logout_outlined,
    //             label: 'Sign out',
    //           ),
    //         ],
    //       );
    //     }
    //     return SidebarX(
    //       controller: SidebarXController(selectedIndex: 0, extended: true),
    //       theme: SidebarXTheme(
    //         margin: const EdgeInsets.all(10),
    //         decoration: BoxDecoration(
    //           color: kPrimary,
    //           borderRadius: BorderRadius.circular(20),
    //         ),
    //         textStyle: const TextStyle(color: Colors.white),
    //         selectedTextStyle: const TextStyle(color: Colors.white),
    //         itemTextPadding: const EdgeInsets.only(left: 30),
    //         selectedItemTextPadding: const EdgeInsets.only(left: 30),
    //         itemDecoration: BoxDecoration(
    //           border: Border.all(color: kPrimary),
    //         ),
    //         selectedItemDecoration: BoxDecoration(
    //           borderRadius: BorderRadius.circular(10),
    //           border: Border.all(
    //             color: actionColor.withOpacity(0.37),
    //           ),
    //           gradient: const LinearGradient(
    //             colors: [accentCanvasColor, canvasColor],
    //           ),
    //           boxShadow: [
    //             BoxShadow(
    //               color: Colors.black.withOpacity(0.28),
    //               blurRadius: 30,
    //             )
    //           ],
    //         ),
    //         iconTheme: const IconThemeData(
    //           color: Colors.white,
    //           size: 20,
    //         ),
    //       ),
    //       extendedTheme: const SidebarXTheme(
    //         width: 200,
    //         decoration: BoxDecoration(
    //           color: kPrimary,
    //         ),
    //         margin: EdgeInsets.only(right: 10),
    //       ),
    //       headerBuilder: (context, extended) {
    //         return SafeArea(
    //           child: InkWell(
    //             onTap: () {
    //               showDialog(
    //                 context: context,
    //                 builder: (context) => SignInDialog(),
    //               );
    //             },
    //             child: SizedBox(
    //               height: 100,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(10),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.start,
    //                   crossAxisAlignment: CrossAxisAlignment.center,
    //                   children: [
    //                     Icon(Icons.login),
    //                     SizedBox(
    //                       width: 30,
    //                     ),
    //                     extended ? Text('Sign In') : Container(),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ),
    //         );
    //       },
    //       items: [
    //         SidebarXItem(
    //           icon: Icons.home,
    //           label: 'Home',
    //           onTap: () {},
    //         ),
    //         const SidebarXItem(
    //           icon: Icons.search,
    //           label: 'Search',
    //         ),
    //         SidebarXItem(
    //           onTap: () async {
    //             if (await utils.isLoggedIn() == "true") {
    //               // print('isLoggedIn');
    //               context.pushNamed(
    //                 'library',
    //               );
    //             } else {
    //               // infoSnakBar(info: 'no logged in').show(context);
    //               // prin
    //               showDialog(
    //                 context: context,
    //                 builder: (context) => SignInDialog(),
    //               );
    //             }
    //           },
    //           icon: Icons.book_outlined,
    //           label: 'Library',
    //         ),
    //       ],
    //     );
    //   },
    // );

    return Drawer(
      width: 0.6.sw,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return Column(
              children: [
                GestureDetector(
                  onTap: () {
                    context.pushNamed('account');
                  },
                  child: DrawerHeader(
                    // decoration: const BoxDecoration(
                    //   color: kRed,
                    // ),
                    child: Column(children: [
                      SizedBox(
                        height: 100,
                        width: 100,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(120),
                          child: state.user.userImageURL != null
                              ? CachedNetworkImage(
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.fill,
                                  imageUrl: state.user.userImageURL!)
                              : Container(),
                        ),
                      ),
                      Text(state.user.email!)
                    ]),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.book_outlined),
                  title: const Text('Library'),
                  onTap: () async {
                    if (await utils.isLoggedIn() == "true") {
                      // print('isLoggedIn');
                      context.pushNamed(
                        'library',
                      );
                    } else {
                      // infoSnakBar(info: 'no logged in').show(context);
                      // prin
                      showDialog(
                        context: context,
                        builder: (context) => SignInDialog(),
                      );
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout),
                  title: const Text('Sign Out'),
                  onTap: () {
                    context
                        .read<AuthenticationBloc>()
                        .add(AuthenticationLogoutRequested());
                  },
                ),
              ],
            );
          }
          if (state.status == AuthenticationStatus.unauthenticated) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => SignInDialog(),
                    );
                  },
                  child: DrawerHeader(
                      padding: EdgeInsets.all(0),
                      // decoration: BoxDecoration(
                      //   color: kRed,
                      // ),
                      child: Center(
                        child: ListTile(
                          leading: Icon(Icons.login_outlined),
                          title: const Text('Sign in now'),
                          onTap: () async {
                            showDialog(
                              context: context,
                              builder: (context) => SignInDialog(),
                            );
                          },
                        ),
                      )),
                ),
                ListTile(
                  leading: Icon(Icons.book_outlined),
                  title: const Text('Library'),
                  onTap: () async {
                    if (await utils.isLoggedIn() == "true") {
                      // print('isLoggedIn');
                      context.pushNamed(
                        'library',
                      );
                    } else {
                      // infoSnakBar(info: 'no logged in').show(context);
                      // prin
                      showDialog(
                        context: context,
                        builder: (context) => SignInDialog(),
                      );
                    }
                  },
                ),
              ],
            );
          }
          if (state.status == AuthenticationStatus.unknown) {
            Container();
          }
          return Container();
          // },
          // );
        },
      ),
      // ),
    );
  }
}

class BuildTab extends StatelessWidget {
  final HomeTab value;
  final HomeTab groupValue;

  const BuildTab({super.key, required this.value, required this.groupValue});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => context.read<HomeBloc>().setTab(value),
        child: Container(
          height: 0.04.sh,
          decoration: BoxDecoration(
            border: Border.all(
              color: groupValue != value ? kGrey : kRed,
              width: 1,
            ),
            // borderRadius: BorderRadius.circular(kBorderRadius),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(child: Text(value.name)),
        ));
  }
}

class HomeView extends StatelessWidget {
  final utils = Utils();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // checkIsLoggedIn();
    final selectedTab = context.select((HomeBloc cubit) => cubit.state.tab);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                // if (state.status == AuthenticationStatus.unknown) {
                //   return IconButton(
                //     constraints: BoxConstraints(),
                //     iconSize: kDefaultIconSize,
                //     // padding: EdgeInsets.zero,
                //     icon: Icon(Icons.login),
                //     onPressed: () {
                //       showDialog(
                //         context: context,
                //         builder: (context) => SignInDialog(),
                //       );
                //     },
                //   );
                // }
                // if (state.status == AuthenticationStatus.unauthenticated) {
                //   return IconButton(
                //     constraints: BoxConstraints(),
                //     iconSize: kDefaultIconSize,
                //     // padding: EdgeInsets.zero,
                //     icon: Icon(Icons.login),
                //     onPressed: () {
                //       showDialog(
                //         context: context,
                //         builder: (context) => SignInDialog(),
                //       );
                //     },
                //   );
                // }
                if (state.status == AuthenticationStatus.authenticated) {
                  return Container();
                }
                return IconButton(
                  constraints: BoxConstraints(),
                  iconSize: kDefaultIconSize,
                  // padding: EdgeInsets.zero,
                  icon: Icon(Icons.login),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SignInDialog(),
                    );
                  },
                );
              },
            ),
            // IconButton(
            //   // padding: EdgeInsets.zero,
            //   constraints: BoxConstraints(),
            //   onPressed: () async {
            //     // await utils.deleteAllSecureData();

            //     if (await utils.isLoggedIn() == "true") {
            //       // print('isLoggedIn');
            //       context.pushNamed(
            //         'payment',
            //       );
            //     } else {
            //       showDialog(
            //         context: context,
            //         builder: (context) => SignInDialog(),
            //       );
            //     }
            //   },
            //   icon: const Icon(Icons.monetization_on),
            // ),
            IconButton(
              // padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: const Icon(Icons.book_outlined),
              onPressed: () async {
                if (await utils.isLoggedIn() == "true") {
                  // print('isLoggedIn');
                  context.pushNamed(
                    'library',
                  );
                } else {
                  // infoSnakBar(info: 'no logged in').show(context);
                  // prin
                  showDialog(
                    context: context,
                    builder: (context) => SignInDialog(),
                  );
                }
              },
              // label: "",
              // onTap: () => {},
            ),
            IconButton(
              // padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () async {
                // BlocProvider(
                //   create: (context) => SearchBloc(),
                // );
                await showSearch(
                    context: context,
                    delegate: SearchView(BlocProvider.of<SearchBloc>(context)));
              },
              icon: const Icon(Icons.search),
              // label: "",
              // onTap: () => {},
            ),
            Builder(
              builder: (context) {
                return IconButton(
                  // padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  // label: "",
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                );
              },
            )
          ],
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                ImagePath.logoPath,
                height: 25,
                //width: 0.35.sw,
                fit: BoxFit.fitHeight,
              ),
              Spacer(),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 1,
                            child: BuildTab(
                              groupValue: selectedTab,
                              value: HomeTab.Ongoing,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            flex: 1,
                            child: BuildTab(
                              groupValue: selectedTab,
                              value: HomeTab.Completed,
                            )),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            flex: 1,
                            child: BuildTab(
                              groupValue: selectedTab,
                              value: HomeTab.Genres,
                            )),
                      ]),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(children: [
                    Expanded(
                        flex: 1,
                        child: BuildTab(
                          groupValue: selectedTab,
                          value: HomeTab.New,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        flex: 1,
                        child: BuildTab(
                          groupValue: selectedTab,
                          value: HomeTab.Ranking,
                        )),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                        flex: 1,
                        child: BuildTab(
                          groupValue: selectedTab,
                          value: HomeTab.Newsfeed,
                        )),
                  ]),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 0.8.sh,
                    child: LazyLoadIndexedStack(
                      // controller: _tabController,
                      index: selectedTab.index,
                      children: [
                        TabOngoingComic(),
                        const TabNewComic(),
                        TabCompletedComic(),
                        TabRankingComic(),
                        const TabGenresComic(),
                        TabNewFeedComic()
                      ],
                    ),
                  ),
                ],
              );
            }

                // },
                ),
          ),
        ),
        endDrawer: BuildSideBar(),
      ),
    );
  }
}
