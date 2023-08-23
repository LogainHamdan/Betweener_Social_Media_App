import 'package:flutter/material.dart';

import '../../core/utils/styles.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool password;
  final IconData? prefix;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;

  const CustomTextFormField(
      {super.key,
      required this.label,
      this.controller,
      this.hint,
      this.password = false,
      this.keyboardType,
      this.validator,
      this.autofillHints,
      this.prefix});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Styles.textStyle14,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          validator: widget.validator,
          autofillHints: widget.autofillHints,
          cursorColor: Colors.blue,
          cursorHeight: 30,
          obscureText: widget.password,
          enableSuggestions: widget.password == true ? false : true,
          autocorrect: widget.password == true ? false : true,
          decoration: InputDecoration(
            prefixIcon: Icon(widget.prefix),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            hintText: widget.hint,
            border: Styles.primaryRoundedOutlineInputBorder,
            focusedBorder: Styles.primaryRoundedOutlineInputBorder,
            errorBorder: Styles.primaryRoundedOutlineInputBorder,
            enabledBorder: Styles.primaryRoundedOutlineInputBorder,
            disabledBorder: Styles.primaryRoundedOutlineInputBorder,
          ),
        ),
      ],
    );
  }
}
