import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

@immutable
class Env {
  static String get(String key) {
    final value = dotenv.env[key];

    if (value == null) {
      throw Exception('Could not find a value with the given [$key]');
    }

    return value;
  }

  const Env._();
}
