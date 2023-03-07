// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:collection';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hikicomic/pages/detail/view/detail_comic_view.dart';
import 'package:hikicomic/pages/home/view/home_view.dart';
import 'package:hikicomic/pages/splash/splash.dart';
import 'package:hikicomic/theme.dart';

import 'pages/read_comic/view/read_comic_view.dart';

void main() {
  runApp(
    //  DevicePreview(enabled: !kReleaseMode, builder: (context) => const MyApp()),
    MyApp(), // Wrap your app
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          theme: darkTheme(context),
          title: 'Hikicomic',
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: ComicDetailView(),

      // builder: (context, child) {
      //   ScreenUtil.init(context);
      //   return Theme(data: lightTheme(context), child: HomeScreen());
      // },
    );
    //  useInheritedMediaQuery: true,
    // locale: DevicePreview.locale(context),
    // builder: DevicePreview.appBuilder,
    // title: 'hikicomic',
    // debugShowCheckedModeBanner: false,
    // theme: lightTheme(context),
    // home: HomeScreen());
  }
}
