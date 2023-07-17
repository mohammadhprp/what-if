import 'package:flutter/material.dart';

class PromptBoxField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? label;
  final int minLine;
  final TextInputAction? action;
  final TextInputType? type;

  const PromptBoxField({
    Key? key,
    required this.controller,
    required this.hint,
    this.label,
    this.minLine = 3,
    this.action = TextInputAction.done,
    this.type = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      textInputAction: action,
      maxLines: null,
      minLines: minLine,
      decoration: InputDecoration(
        filled: true,
        hintText: hint,
        labelText: label,
      ),
    );
  }
}
