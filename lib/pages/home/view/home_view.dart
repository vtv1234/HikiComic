import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:go_router/go_router.dart';
import 'package:hikicomic/pages/authentication/authentication.dart';
import 'package:hikicomic/pages/search/bloc/search_bloc.dart';
import 'package:hikicomic/pages/search/view/search_view.dart';
import 'package:hikicomic/pages/sign_in/view/sign_in_view.dart';
import 'package:hikicomic/pages/tabs/completed_comic/view/completed_comic_view.dart';
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
import 'package:hikicomic/widget/loading_screen.dart';
import 'package:loader_overlay/loader_overlay.dart';

const primaryColor = Color(0xFF685BFF);
const canvasColor = Color(0xFF2E2E48);
const scaffoldBackgroundColor = Color(0xFF464667);
const accentCanvasColor = Color(0xFF3E3E61);

const actionColor = Color(0xFF5F5FA7);

final divider = Divider(color: kWhite.withOpacity(0.3), height: 1);

class HomeScreen extends StatefulWidget {
  static List<String> homeTab = [
    'Ongoing',
    'New',
    'Completed',
    'Ranking',
    'Genres',
    'Newsfeed',
  ];

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => HomeBloc(), child: const HomeView());
  }
}

class BuildSideBar extends StatefulWidget {
  const BuildSideBar({
    super.key,
  });

  @override
  State<BuildSideBar> createState() => _BuildSideBarState();
}

class _BuildSideBarState extends State<BuildSideBar> {
  @override
  Widget build(BuildContext context) {
    final utils = Utils();

    return LoaderOverlay(
      closeOnBackButton: true,
      disableBackButton: false,
      child: Drawer(
        width: 0.6.sw,
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            // if (state.status == AuthenticationStatus.unknown) {
            //   context.loaderOverlay.show(widget: LoadingScreen());
            // }
          },
          builder: (context, state) {
            if (state.status == AuthenticationStatus.authenticated) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.pushNamed('account');
                    },
                    child: DrawerHeader(
                      child: Column(children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(120),
                            child: state.user.userImageURL != "default.png"
                                ? CachedNetworkImage(
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                    fit: BoxFit.fill,
                                    imageUrl: state.user.userImageURL!)
                                : Image.asset(ImagePath.userAvatarImagePath),
                          ),
                        ),
                        Text(state.user.email!)
                      ]),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.book_outlined),
                    title: const Text('Library'),
                    onTap: () async {
                      if (await utils.methodLogin() != "") {
                        if (mounted) {
                          context.pushNamed(
                            'library',
                          );
                        }
                      } else {
                        if (mounted) {
                          showDialog(
                            context: context,
                            builder: (context) => const SignInDialog(),
                          );
                        }
                      }
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
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
                        builder: (context) => const SignInDialog(),
                      );
                    },
                    child: DrawerHeader(
                        padding: const EdgeInsets.all(0),
                        child: Center(
                          child: ListTile(
                            leading: const Icon(Icons.login_outlined),
                            title: const Text('Sign in now'),
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) => const SignInDialog(),
                              );
                            },
                          ),
                        )),
                  ),
                  ListTile(
                    leading: const Icon(Icons.book_outlined),
                    title: const Text('Library'),
                    onTap: () async {
                      if (await utils.methodLogin() != "") {
                        if (mounted) {
                          context.pushNamed(
                            'library',
                          );
                        }
                      } else {
                        if (mounted) {
                          showDialog(
                            context: context,
                            builder: (context) => const SignInDialog(),
                          );
                        }
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
          },
        ),
      ),
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
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(child: Text(value.name)),
        ));
  }
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final utils = Utils();

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeBloc cubit) => cubit.state.tab);
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          actions: [
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
                if (state.status == AuthenticationStatus.authenticated) {
                  return Container();
                }
                return IconButton(
                  constraints: const BoxConstraints(),
                  iconSize: kDefaultIconSize,
                  icon: const Icon(Icons.login),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const SignInDialog(),
                    );
                  },
                );
              },
            ),
            IconButton(
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.book_outlined),
              onPressed: () async {
                if (await utils.methodLogin() != "") {
                  if (mounted) {
                    context.pushNamed(
                      'library',
                    );
                  }
                } else {
                  if (mounted) {
                    showDialog(
                      context: context,
                      builder: (context) => const SignInDialog(),
                    );
                  }
                }
              },
            ),
            IconButton(
              constraints: const BoxConstraints(),
              onPressed: () async {
                await showSearch(
                    context: context,
                    delegate: SearchView(BlocProvider.of<SearchBloc>(context)));
              },
              icon: const Icon(Icons.search),
            ),
            Builder(
              builder: (context) {
                return IconButton(
                  constraints: const BoxConstraints(),
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
              const Spacer(),
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
                  Row(children: [
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
                  SizedBox(
                    height: 0.8.sh,
                    child: LazyLoadIndexedStack(
                      index: selectedTab.index,
                      children: const [
                        TabOngoingComic(),
                        TabNewComic(),
                        TabCompletedComic(),
                        TabRankingComic(),
                        TabGenresComic(),
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
        endDrawer: const BuildSideBar(),
      ),
    );
  }
}
