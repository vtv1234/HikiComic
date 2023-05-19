import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hikicomic/pages/splash/bloc/splash_bloc.dart';
import 'package:hikicomic/repository/authentication_repository.dart';
import 'package:hikicomic/utils/img_path.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
            create: (context) => SplashBloc(
                authenticationRepository:
                    RepositoryProvider.of<AuthenticationRepository>(context))
              ..add(GetUserEvent()),
            child: Scaffold(
              body: BlocListener<SplashBloc, SplashState>(
                // bloc: Slo,
                listener: (context, state) {
                  if (state is SplashLoadedState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Timer(const Duration(seconds: 1),
                          () => context.goNamed('home'));
                    });
                    // Center(child: Image.asset(ImagePath.logoPath));
                  }
                  if (state is SplashErrorState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Timer(const Duration(seconds: 1),
                          () => context.goNamed('home'));
                    });
                    // Center(child: Image.asset(ImagePath.logoPath));
                  }
                },
                child: BlocBuilder<SplashBloc, SplashState>(
                  builder: (context, state) {
                    if (state is SplashLoadingState) {
                      return Center(child: Image.asset(ImagePath.logoPath));
                    }
                    if (state is SplashLoadedState) {
                      return Center(child: Image.asset(ImagePath.logoPath));
                    }
                    if (state is SplashErrorState) {
                      return Center(child: Image.asset(ImagePath.logoPath));
                    }
                    return Container();
                  },
                ),
              ),
            )));
  }
}
