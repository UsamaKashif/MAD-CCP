// create an input field
// 1. create a stateful widget

import 'package:flutter/material.dart';
import 'package:mad_ccp/utils/fonts.dart';

class Input extends StatefulWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const Input(
      {super.key,
      required this.hintText,
      this.obscureText = false,
      required this.controller});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: AppFonts.openSans,
          fontSize: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsetsDirectional.all(16),
      ),
    );
  }
}
