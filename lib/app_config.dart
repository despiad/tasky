import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
   bool get isProduction =>
      kReleaseMode || environment.toLowerCase().startsWith('prod');

   String get environment => dotenv.env['ENVIRONMENT'] ?? 'dev';

  Future<void> load() async {
    await dotenv.load(fileName: 'assets/.env');
    debugPrint('ENVIRONMENT: $environment');
  }
}
