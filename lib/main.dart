import 'package:aptabase_flutter/aptabase_flutter.dart';
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
  final supabaseUrl = Env.get(EnvKey.supabaseUrl);
  final supabaseKey = Env.get(EnvKey.supabaseAnonKey);

  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseKey,
  );

  // initialize Aptabase
  final aptabaseKey = Env.get(EnvKey.aptabaseKey);
  await Aptabase.init(aptabaseKey);

  runApp(const ProviderScope(child: App()));
}
