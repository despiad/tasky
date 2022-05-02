import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  bool get isProduction =>
      kReleaseMode || environment.toLowerCase().startsWith('prod');

  String get environment => dotenv.env['ENVIRONMENT'] ?? 'dev';

  Future<void> load() async {
    if (kReleaseMode) {
      await dotenv.load(fileName: 'assets/config/.env.prod');
    } else {
      await dotenv.load(fileName: 'assets/config/.env.dev');
    }
    debugPrint('ENVIRONMENT: $environment');
  }
}
