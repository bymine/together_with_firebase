import 'package:flutter/material.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? preFixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? obscureText;
  final TextInputType? inputType;
  final bool? readOnly;

  final String? Function(String?)? validator;
  const TextInputField(
      {Key? key,
      this.controller,
      this.preFixIcon,
      this.suffixIcon,
      this.obscureText,
      this.hintText,
      this.validator,
      this.readOnly,
      this.inputType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly ?? false,
      obscureText: obscureText ?? false,
      controller: controller,
      keyboardType: inputType,
      maxLines: inputType == TextInputType.multiline ? null : 1,
      decoration: InputDecoration(
        prefixIcon: preFixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
      ),
      validator: validator,
    );
  }
}
