import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hikicomic/utils/bloc_observert.dart';
import 'app.dart';

void main() {
  Bloc.observer = const HikiComicBlocObserver();
  HttpOverrides.global = MyHttpOverrides();
  // WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const App(), // Wrap your app
  );
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
