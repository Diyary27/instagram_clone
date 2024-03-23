import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  TextFieldInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.textInputType,
    this.isObscure = false,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType textInputType;
  final bool isObscure;

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        filled: true,
        contentPadding: EdgeInsets.all(8),
      ),
      keyboardType: textInputType,
      obscureText: isObscure,
    );
  }
}
