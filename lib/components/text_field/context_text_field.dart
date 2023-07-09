import 'package:flutter/material.dart';

class ContextTextField extends StatelessWidget {
  final String hint;
  final String? label;
  final TextEditingController controller;
  final TextInputAction? action;
  final TextInputType? type;

  const ContextTextField({
    Key? key,
    required this.hint,
    this.label,
    required this.controller,
    this.action = TextInputAction.next,
    this.type = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      textInputAction: action,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        labelText: label,
      ),
    );
  }
}
