import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/app.dart';
import 'constants/env/env.dart';
import 'constants/env/env_key.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Load .env file
  await dotenv.load(fileName: ".env");

  // initialize Supabase
  final url = Env.get(EnvKey.supabaseUrl);
  final key = Env.get(EnvKey.supabaseAnonKey);

  await Supabase.initialize(
    url: url,
    anonKey: key,
  );

  runApp(const ProviderScope(child: App()));
}
