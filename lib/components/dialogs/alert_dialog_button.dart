import 'package:flutter/material.dart';

@immutable
class AlertDialogButton<T> {
  final Map<String, T> content;

  const AlertDialogButton({
    required this.content,
  });
}
