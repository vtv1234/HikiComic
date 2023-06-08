import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hikicomic/pages/account/bloc/account_bloc.dart';
import 'package:hikicomic/pages/account/view/account_view.dart';
import 'package:hikicomic/pages/home/view/home_view.dart';
import 'package:hikicomic/pages/library/view/library_view.dart';
import 'package:hikicomic/pages/read_comic/view/read_comic_view.dart';
import 'package:hikicomic/pages/sign_in_with_google/view/sign_in_with_google_view.dart';
import 'package:hikicomic/pages/sign_up/sign_up_view.dart';
import 'package:hikicomic/pages/splash/view/splash.dart';
import 'package:hikicomic/utils/device_info.dart';
import 'package:hikicomic/utils/theme.dart';

import 'pages/authentication/authentication.dart';
import 'pages/comic_detail/view/comic_detail_view.dart';
import 'pages/comic_genre/view/comic_genre_view.dart';
import 'pages/forgot_password/view/forgot_password_view.dart';
import 'pages/otp/otp.dart';
import 'pages/payment/view/payment_view.dart';
import 'pages/reset_password/view/reset_password_view.dart';
import 'pages/search/bloc/search_bloc.dart';

import 'pages/verify_forgot_password/view/verfify_forgot_password_view.dart';
import 'repository/authentication_repository.dart';
import 'repository/user_repository.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;
  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: RepositoryProvider.value(
        value: _authenticationRepository,
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => AuthenticationBloc(
                  authenticationRepository: _authenticationRepository,
                  userRepository: _userRepository),
            ),
            BlocProvider(
              create: (context) => SearchBloc(),
            ),
            BlocProvider(
              create: (context) => AccountBloc(
                  authenticationRepository: _authenticationRepository)
                ..add(GetAccountInformation()),
            )
          ],
          child: const AppView(),
        ),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({
    Key? key,
  }) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  late Map<String, dynamic> _deviceData = <String, dynamic>{};
  final DeviceInfo _deviceInfo = DeviceInfo();
  static const platform = MethodChannel('com.example.hikicomic/androidId');
  String androidId = '';
  // final _navigatorKey = GlobalKey<NavigatorState>();

  // NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> getDeviceId() async {
    try {
      final String result = await platform.invokeMethod('getAndroidId');
      androidId = result;
    } on PlatformException catch (e) {
      print(e.details);
      androidId = "";
    }
  }

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        deviceData = _deviceInfo
            .readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        switch (defaultTargetPlatform) {
          // TargetPlatform.android =>
          //   _readAndroidBuildData(await deviceInfoPlugin.androidInfo),
          // TargetPlatform.iOS =>
          //   _readIosDeviceInfo(await deviceInfoPlugin.iosInfo),
          // TargetPlatform.linux =>
          //   _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo),
          // TargetPlatform.windows =>
          //   _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo),
          // TargetPlatform.macOS =>
          //   _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo),
          // TargetPlatform.fuchsia => <String, dynamic>{
          //     'Error:': 'Fuchsia platform isn\'t supported'
          //   },
          case TargetPlatform.android:
            deviceData = _deviceInfo
                .readAndroidBuildData(await deviceInfoPlugin.androidInfo);
            getDeviceId();
            break;
          case TargetPlatform.fuchsia:
            // TODO: Handle this case.
            break;
          case TargetPlatform.iOS:
            // TODO: Handle this case.
            break;
          case TargetPlatform.linux:
            // TODO: Handle this case.
            break;
          case TargetPlatform.macOS:
            // TODO: Handle this case.
            break;
          case TargetPlatform.windows:
            // TODO: Handle this case.
            break;
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(androidId);
    print(_deviceData);
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp.router(
          routeInformationProvider: _router.routeInformationProvider,
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          theme: darkTheme(context),
          title: 'HikiComic',
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }

  final GlobalKey<NavigatorState> _navigatorState = GlobalKey<NavigatorState>();
  late final GoRouter _router = GoRouter(
      initialLocation: '/splash',
      navigatorKey: _navigatorState,
      routes: [
        GoRoute(
          name: 'splash',
          path: '/splash',
          builder: (BuildContext context, GoRouterState state) =>
              const SplashScreen(),
        ),
        // GoRoute(
        //   name: 'login-page',
        //   path: '/login-page',
        //   builder: (BuildContext context, GoRouterState state) => LoginPage(),
        // ),
        GoRoute(
          name: 'home',
          path: '/home',
          builder: (BuildContext context, GoRouterState state) =>
              const HomeScreen(),
        ),
        GoRoute(
          name: 'details',
          path: '/details/:comicSEOAlias/:comicId',
          builder: (BuildContext context, GoRouterState state) {
            return ComicDetailView(
              comicSEOAlias: state.params['comicSEOAlias']!,
              comicId: state.params['comicId']!,
            );
          },
        ),
        GoRoute(
          name: 'read-comic',
          path: '/read-comic/:comicSEOAlias/:chapterSEOAlias',
          builder: (BuildContext context, GoRouterState state) {
            return ReadComicView(
              comicSEOAlias: state.params['comicSEOAlias']!,
              chapterSEOAlias: state.params['chapterSEOAlias']!,
            );
          },
        ),
        GoRoute(
          name: 'payment',
          path: '/payment',
          builder: (BuildContext context, GoRouterState state) {
            return const PaymentView();
          },
        ),
        GoRoute(
          name: 'sign-up',
          path: '/sign-up',
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpView();
          },
        ),
        GoRoute(
          name: 'forgot-password',
          path: '/forgot-password',
          builder: (BuildContext context, GoRouterState state) {
            return ForgotPasswordScreen();
          },
        ),
        GoRoute(
          name: 'verify-forgot-password',
          path: '/verify-forgot-password/:email',
          builder: (BuildContext context, GoRouterState state) {
            return VerifyForgotPasswordScreen(email: state.params['email']);
          },
        ),
        GoRoute(
          name: 'reset-password',
          path: '/reset-password/:email',
          builder: (BuildContext context, GoRouterState state) {
            return ResetPasswordView(
              email: state.params['email'],
            );
          },
        ),
        GoRoute(
          name: 'otp',
          path: '/otp-verification/:email/:password',
          builder: (BuildContext context, GoRouterState state) {
            return OTPScreen(
              email: state.params['email'],
              password: state.params['password'],
            );
          },
        ),
        GoRoute(
          name: 'library',
          path: '/library',
          builder: (BuildContext context, GoRouterState state) {
            return const LibrarySceen();
          },
        ),
        GoRoute(
          name: 'comic-genre',
          path: '/comic-genre/:genre',
          builder: (BuildContext context, GoRouterState state) {
            return ComicGenreView(
              selectedGenre: state.params['genre']!,
            );
          },
        ),
        GoRoute(
          name: 'account',
          path: '/account',
          builder: (BuildContext context, GoRouterState state) {
            return const AccountView();
          },
        ),
      ]);
}
