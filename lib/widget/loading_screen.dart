import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hikicomic/utils/colors.dart';
import 'package:hikicomic/widget/jumping_dot.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key, this.message});

  final String? message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SpinKitFadingCircle(
              size: 50,
              color: kRed,
            ),
            message != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(message ?? ""),
                      JumpingDots(
                        color: kWhite,
                      )
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
