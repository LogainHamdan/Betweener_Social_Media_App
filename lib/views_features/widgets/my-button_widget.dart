import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final Function()? onTap;
  final bool ConfirmAnswer;
  const MyButton({
    super.key,
    required this.text,
    this.onTap,
    this.isLoading = false,
    this.ConfirmAnswer = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // splashColor: Colors.transparent,
      // highlightColor: Colors.transparent,
      onTap: onTap,
      /*avoid to () because the callable function is sent  with ()*/
      child: Container(
          height: 45,
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(horizontal: 80.w),
          width: double.infinity,
          decoration: BoxDecoration(
              color: ConfirmAnswer == true ? Color(0xffFFD465) : Colors.green,
              borderRadius: BorderRadius.circular(10),
              border: ConfirmAnswer == true
                  ? Border.all(color: Colors.black)
                  : null),
          child: !isLoading
              ? Text(text.toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold))
              : const CircularProgressIndicator()),
    );
  }
}
