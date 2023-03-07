import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ReadComicView extends StatefulWidget {
  ReadComicView({super.key});

  @override
  State<ReadComicView> createState() => _ReadComicViewState();
}

class _ReadComicViewState extends State<ReadComicView>
    with TickerProviderStateMixin {
  late final ScrollListener _model;
  late final ScrollController _controller;
  final double _bottomNavBarHeight = 57;
  List<String> images = [
    "https://img-3.kunmanga.com/manga_63f17666e1937/chapter-4/001.jpg",
    "https://img-3.kunmanga.com/manga_63f17666e1937/chapter-4/002.jpg",
    "https://img-3.kunmanga.com/manga_63f17666e1937/chapter-4/003.jpg",
    "https://img-3.kunmanga.com/manga_63f17666e1937/chapter-4/004.jpg",
    "https://img-3.kunmanga.com/manga_63f17666e1937/chapter-4/005.jpg",
    "https://img-3.kunmanga.com/manga_63f17666e1937/chapter-4/006.jpg",
    "https://img-3.kunmanga.com/manga_63f17666e1937/chapter-4/007.jpg",
    "https://img-3.kunmanga.com/manga_63f17666e1937/chapter-4/008.jpg",
    "https://img-3.kunmanga.com/manga_63f17666e1937/chapter-4/009.jpg"
  ];
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _model = ScrollListener.initialise(_controller);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: _model,
          builder: (context, child) => Stack(children: [
            CustomScrollView(
              controller: _controller,
              slivers: [
                SliverAppBar(
                  floating: true,
                  titleSpacing: 0,
                  actions: [
                    IconButton(
                        onPressed: () {}, icon: Icon(Icons.home_outlined))
                  ],
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.maybePop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Episode 1'),
                            Text(
                              'A mother and her daughter',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.fontSize),
                            )
                          ]),
                    ],
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  childCount: images.length,
                  (context, index) =>
                      CachedNetworkImage(imageUrl: images[index]),
                )),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: _model.bottom,
              child: _bottomNavBar,
            ),
          ]),
        ),
      ),
    );
  }

  Widget get _bottomNavBar {
    return SizedBox(
      height: _bottomNavBarHeight,
      child: BottomNavigationBar(
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        currentIndex: 0,

        //backgroundColor: Colors.amber,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_back_outlined), label: 'Prev'),
          BottomNavigationBarItem(
              icon: Icon(Icons.thumb_up_outlined), label: 'Like'),
          BottomNavigationBarItem(
              icon: Icon(Icons.comment_outlined), label: 'Comment'),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Chapter'),
          BottomNavigationBarItem(
              icon: Icon(Icons.arrow_forward_outlined), label: 'Next'),
        ],
      ),
    );
  }
}

class ScrollListener extends ChangeNotifier {
  double bottom = 0;
  double _last = 0;

  ScrollListener.initialise(ScrollController controller, [double height = 57]) {
    controller.addListener(() {
      final current = controller.offset;
      bottom += _last - current;
      if (bottom <= -height) bottom = -height;
      if (bottom >= 0) bottom = 0;
      _last = current;
      if (bottom <= 0 && bottom >= -height) notifyListeners();
    });
  }
}
