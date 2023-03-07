// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hikicomic/data/models/comic.dart';

import 'package:hikicomic/img_path.dart';
import 'package:hikicomic/pages/home/view/item_home_movie.dart';
import 'package:hikicomic/repository/comic_repository.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'widgets/button_icon.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  late ComicRepository comicRepository = ComicRepository();
  late List<Comic> hotComics;
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  void initState() {
    hotComics = [
      Comic(
          comicId: 1,
          comicCoverImageURL:
              'https://kunmanga.com/wp-content/uploads/2023/02/I-Became-The-Male-Leads-Female-Friend-kun-350x476.jpg'),
      Comic(
          comicId: 2,
          comicCoverImageURL:
              'https://kunmanga.com/wp-content/uploads/2023/02/I-Became-The-Male-Leads-Female-Friend-kun-350x476.jpg'),
      Comic(
          comicId: 3,
          comicCoverImageURL:
              'https://kunmanga.com/wp-content/uploads/2023/02/I-Became-The-Male-Leads-Female-Friend-kun-350x476.jpg'),
      Comic(
          comicId: 4,
          comicCoverImageURL:
              'https://kunmanga.com/wp-content/uploads/2023/02/I-Became-The-Male-Leads-Female-Friend-kun-350x476.jpg')
    ];
    super.initState();
  }

  void getHotComics() async {
    hotComics = await comicRepository.getHotComics();
    //setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildCarouselSlideComic(),
                ListTile(
                    horizontalTitleGap: 5,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                    title: Text(
                      "Today's Comic",
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    trailing: Text('See All',
                        style: Theme.of(context).textTheme.bodySmall)),
                SizedBox(
                    height: 0.2.sh,
                    child: ListView.builder(
                        // itemExtent: ,
                        itemCount: hotComics.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: CachedNetworkImage(
                                  width: 0.33.sw,
                                  imageUrl:
                                      hotComics[index].comicCoverImageURL!),
                            ))),
              ],
            ),
          ),
        ),
        endDrawer: _buildSideBar(),
        appBar: _buildAppBar());
  }

  Stack buildCarouselSlideComic() {
    return Stack(children: [
      CarouselSlider.builder(
        options: CarouselOptions(
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
              // print("${_current}");
            });
          },
          height: 0.5.sh,
          enlargeFactor: 0.5,

          enlargeCenterPage: true,
          viewportFraction: 0.5,
          // viewportFraction: 1,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: Duration(seconds: 4),
          autoPlayAnimationDuration: Duration(milliseconds: 1500),
          autoPlayCurve: Curves.fastOutSlowIn,
          //enlargeCenterPage: true,
        ),
        itemCount: hotComics.length,
        itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) {
          final data = hotComics[itemIndex];
          return ItemComic(data);
        },
      ),
      Positioned(
          left: 50.w,
          bottom: 20.w,
          child: AnimatedSmoothIndicator(
            activeIndex: _current,
            count: hotComics.length,
            effect: const ExpandingDotsEffect(
                expansionFactor: 2,
                activeDotColor: Colors.red,
                dotHeight: 8,
                dotWidth: 8),
          )),
      // Positioned(
      //   left: 50.w,
      //   bottom: 20.w,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: hotComics.asMap().entries.map((entry) {
      //       return GestureDetector(
      //         onTap: () => _controller.animateToPage(entry.key),
      //         child: Container(
      //           width: 12.0,
      //           height: 12.0,
      //           margin: EdgeInsets.symmetric(
      //               vertical: 8.0, horizontal: 4.0),
      //           decoration: BoxDecoration(
      //               shape: BoxShape.circle,
      //               color: (Theme.of(context).brightness ==
      //                           Brightness.dark
      //                       ? Colors.white
      //                       : Colors.black)
      //                   .withRed(_current == entry.key ? 255 : 0)
      //               // .withOpacity(
      //               //     _current == entry.key ? 0.9 : 0.4)
      //               ),
      //         ),
      //       );
      //     }).toList(),
      // ),
      // )
    ]);
  }

  AppBar _buildAppBar() {
    return AppBar(
      //toolbarHeight: 60,
      //iconTheme: IconThemeData(color: Colors.black),
      //backgroundColor: Colors.amber,

      actions: [
        ButtonIcon(
          icon: Icons.monetization_on,
          label: "Coins",
          onTap: () => {},
        ),
        ButtonIcon(
          icon: Icons.book_outlined,
          label: "Library",
          onTap: () => {},
        ),
        ButtonIcon(
          icon: Icons.search,
          label: "Search",
          onTap: () => {},
        ),
        Builder(
          builder: (context) {
            return ButtonIcon(
              label: "Menu",
              icon: Icons.menu,
              onTap: () => Scaffold.of(context).openEndDrawer(),
            );
          },
        )
      ],
      automaticallyImplyLeading: false,
      title: Image.asset(
        ImagePath.logoPath,
        width: 150,
        fit: BoxFit.fitWidth,
      ),
    );
  }

  Drawer _buildSideBar() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(children: [
              CircleAvatar(
                child: Image.asset(ImagePath.logoPath),
              )
            ]),
          ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Item 2'),
            onTap: () {
              // Update the state of the app.
              // ...
            },
          ),
        ],
      ),
    );
  }
}
