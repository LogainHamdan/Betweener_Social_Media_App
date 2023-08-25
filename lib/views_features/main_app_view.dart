import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views_features/profile/profile_view.dart';
import 'package:tt9_betweener_challenge/views_features/recieve/receive_view.dart';
import 'package:tt9_betweener_challenge/views_features/widgets/custom_floating_nav_bar.dart';

import 'home/home_view.dart';

class MainAppView extends StatefulWidget {
  static String id = '/mainAppView';

  const MainAppView({super.key});

  @override
  State<MainAppView> createState() => _MainAppViewState();
}

class _MainAppViewState extends State<MainAppView> {
  int _currentIndex = 1;

  late List<Widget?> screensList = [
    const ReceiveView(),
    const HomeView(),
    ProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: screensList[_currentIndex],
      extendBody: true,
      bottomNavigationBar: CustomFloatingNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
