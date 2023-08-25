import 'package:flutter/material.dart';

import '../../core/utils/constants.dart';

class FollowUnfollowButton extends StatelessWidget {
  final bool isFollowed;
  final void Function()? followFunction;
  final void Function()? unfollowFunction;

  FollowUnfollowButton(
      {Key? key,
      this.followFunction,
      this.unfollowFunction,
      required this.isFollowed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isFollowed ? unfollowFunction : followFunction,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          isFollowed
              ? const Color(0xff2D2B4E)
              : kSecondaryColor, // Customize the colors as needed
        ),
      ),
      child: Text(
        isFollowed ? 'Unfollow' : 'Follow',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white, // Customize the text color
        ),
      ),
    );
  }
}
