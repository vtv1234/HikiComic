import 'package:flutter/material.dart';
import 'package:hikicomic/img_path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.white,
          child: Center(
            child: Image.asset(ImagePath.logoPath),
          )),
    );
  }
}
