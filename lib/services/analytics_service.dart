import 'package:aptabase_flutter/aptabase_flutter.dart';
import 'package:flutter/foundation.dart';

class AnalyticsService {
  static void track({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    // Don't track event in debug mode
    if (!kDebugMode) {
      await Aptabase.instance.trackEvent(key, value);
    }
  }
}
