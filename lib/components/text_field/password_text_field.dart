import 'package:flutter/material.dart';

class PasswordTextField extends StatelessWidget {
  final String hint;
  final String? label;
  final TextEditingController controller;
  final TextInputAction? action;

  const PasswordTextField({
    Key? key,
    required this.hint,
    this.label,
    required this.controller,
    this.action = TextInputAction.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: action,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        labelText: label,
      ),
    );
  }
}
