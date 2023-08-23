import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tt9_betweener_challenge/views_features/onbording/onbording_view.dart';
import 'package:tt9_betweener_challenge/views_features/search/search_view.dart';

import 'views_features/auth/login_view.dart';
import 'views_features/auth/register_view.dart';
import 'views_features/home/home_view.dart';
import 'views_features/links/add_link_view.dart';
import 'views_features/links/edit_link_view.dart';
import 'loading/loading_view.dart';
import 'views_features/main_app_view.dart';
import 'views_features/map_view.dart';
import 'views_features/profile/profile_view.dart';
import 'views_features/recieve/receive_view.dart';
import 'core/utils/constants.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (BuildContext context, Widget? child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Betweener',
            theme: ThemeData(
                useMaterial3: true,
                colorSchemeSeed: kPrimaryColor,
                appBarTheme: const AppBarTheme(
                  titleTextStyle: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                  ),
                ),
                scaffoldBackgroundColor: kScaffoldColor),
            home: const OnBordingView(),
            routes: {
              LoadingView.id: (context) => const LoadingView(),
              AddLinkView.id: (context) => AddLinkView(),
              LoginView.id: (context) => const LoginView(),
              RegisterView.id: (context) => const RegisterView(),
              HomeView.id: (context) => const HomeView(),
              MainAppView.id: (context) => const MainAppView(),
              ProfileView.id: (context) => const ProfileView(),
              ReceiveView.id: (context) => const ReceiveView(),
              EditLinkView.id: (context) => EditLinkView(),
              GoogleMapView.id: (context) => const GoogleMapView(),
              SearchView.id: (context) => const SearchView(),
              OnBordingView.id: (context) => const OnBordingView(),
            },
          );
        });
  }
}
