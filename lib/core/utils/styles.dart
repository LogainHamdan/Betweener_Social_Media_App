import 'package:flutter/material.dart';

import 'constants.dart';

mixin class Styles {
  getColor({required Color color}) {
    return color;
  }

  static OutlineInputBorder primaryRoundedOutlineInputBorder =
      OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.grey));

  static const textStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: kPrimaryColor,
  );
}
