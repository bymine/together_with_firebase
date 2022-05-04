import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? preFixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? obscureText;
  final TextInputType? inputType;
  final String? Function(String?)? validator;
  const TextInputField(
      {Key? key,
      this.controller,
      this.preFixIcon,
      this.suffixIcon,
      this.obscureText,
      this.hintText,
      this.validator,
      this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      controller: controller,
      keyboardType: inputType,
      decoration: InputDecoration(
        prefixIcon: preFixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
      validator: validator,
    );
  }
}
