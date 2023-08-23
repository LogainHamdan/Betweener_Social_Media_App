import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tt9_betweener_challenge/core/utils/assets.dart';

import '../../core/utils/constants.dart';
import '../auth/login_view.dart';
import '../widgets/secondary_button_widget.dart';

class OnBordingView extends StatelessWidget {
  static String id = '/onBoardingView';

  const OnBordingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Spacer(),
            SvgPicture.asset(AssetsData.onBoardingImage),
            const Text(
              'Just one Scan for everything',
              style: TextStyle(
                  fontSize: 16,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            SecondaryButtonWidget(
              text: 'Get Started',
              width: double.infinity,
              onTap: () {
                Navigator.pushNamed(context, LoginView.id);
              },
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
