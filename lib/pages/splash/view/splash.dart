import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hikicomic/pages/authentication/authentication.dart';
import 'package:hikicomic/pages/home/view/home_view.dart';
import 'package:hikicomic/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:hikicomic/pages/splash/bloc/splash_bloc.dart';
import 'package:hikicomic/repository/authentication_repository.dart';
import 'package:hikicomic/repository/user_repository.dart';
import 'package:hikicomic/utils/img_path.dart';

import '../../otp/otp.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // @override
  @override
  Widget build(BuildContext context) {
    // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
    // Timer(
    //   Duration(seconds: 3),
    //   () => context.go('/home'),
    // () => Navigator.of(context).push(MaterialPageRoute(
    //     builder: (BuildContext context) => HomeScreen())
    // )
    // );
    // });
    return Scaffold(
        // key: _scaffoldKey,
        body:
            //   Center(child: Image.asset("assets/images/HiKiComic-Logo.png")),
            // );
            BlocProvider(
                create: (context) => SplashBloc(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context))
                  ..add(GetUserEvent()),
                child: Scaffold(
                  body: BlocListener<SplashBloc, SplashState>(
                    // bloc: Slo,
                    listener: (context, state) {
                      if (state is SplashLoadedState) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Timer(
                              Duration(seconds: 1),
                              () =>
                                  // => Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           PinCodeVerificationScreen(),
                                  // ))
                                  context.goNamed('home'));
                        });
                        Center(child: Image.asset(ImagePath.logoPath));
                      }
                    },
                    child: BlocBuilder<SplashBloc, SplashState>(
                      builder: (context, state) {
                        if (state is SplashLoadingState) {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => HomeScreen(),
                          //     ));
                          // if (!mounted) return;
                          // WidgetsBinding.instance.addPostFrameCallback((_) {
                          //   Timer(Duration(seconds: 3), () => Ns);
                          // });
                          // Timer(Duration(seconds: 3), () => context.pushNamed('home'));
                          // Future.delayed(
                          //   Duration(seconds: 2),
                          //   () => context.pushNamed('home'),
                          // );
                          return Center(child: Image.asset(ImagePath.logoPath));
                        }
                        if (state is SplashLoadedState) {
                          // WidgetsBinding.instance.addPostFrameCallback((_) {
                          //   // Timer(Duration(seconds: 3), () =>
                          //   context.go('/home');
                          // });
                          return Center(child: Image.asset(ImagePath.logoPath));
                          // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                          //   Future.delayed(
                          //     Duration(seconds: 1),
                          //     () => context.pushNamed('home'),
                          //   );
                          // });
                          // Future.delayed(
                          //   Duration(seconds: 1),
                          //   () => context.goNamed('home'),
                          // );
                        }

                        // SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                        //   context.goNamed('home');

                        if (state is SplashErrorState) {
                          // WidgetsBinding.instance.addPostFrameCallback((_) {
                          //   Timer(Duration(seconds: 3),
                          //   () =>
                          // context.go('/home');
                          //     Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HomeScreen(),
                          //   ),
                          // ),
                          //       );
                          // });
                          // Future.delayed(
                          //   Duration(seconds: 1),
                          //   () =>
                          // Timer(Duration(seconds: 3), () => context.pushNamed('home'));
                          return Center(child: Image.asset(ImagePath.logoPath));
                          // );
                          // print(state.error);
                          // SchedulerBinding.instance
                          //     .addPostFrameCallback((timeStamp) => context.go('/home'));
                        }
                        return Container();
                      },
                      // listener: (context, state) {
                      //   switch (state.status) {
                      //     case AuthenticationStatus.authenticated:
                      //       RepositoryProvider.of<AuthenticationRepository>(context)
                      //           .controller
                      //           .add(AuthenticationStatus.authenticated);
                      //       // BlocProvider<SignInBloc>(
                      //       //   create: (context) => SignInBloc(
                      //       //           authenticationRepository:
                      //       //               RepositoryProvider.of<AuthenticationRepository>(
                      //       //                       context)
                      //       //                   .controller
                      //       //                   .add(AuthenticationStatus.authenticated))
                      //       //       .add(SignInLoadingEvent(email: null, password: null)),
                      //       // );
                      //       Future.delayed(
                      //           Duration(seconds: 2), () => context.pushNamed('home'));

                      //       break;
                      //     case AuthenticationStatus.unauthenticated:
                      //       Future.delayed(
                      //           Duration(seconds: 2), () => context.pushNamed('home'));

                      //       break;
                      //     case AuthenticationStatus.unknown:
                      //       break;
                      //   }
                      // },
                      // child: Center(child: Image.asset("assets/images/HiKiComic-Logo.png")),
                      // child: child,
                    ),
                  ),
                )));
  }
}
