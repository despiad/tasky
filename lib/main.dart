import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/app_config.dart';
import 'package:tasky/bloc_observer.dart';
import 'package:tasky/injection_container.dart';
import 'package:tasky/utils/constants.dart';
import 'localization/codegen_loader.g.dart';
import 'app.dart';

Future<void> main() async {
  setupDependencies();
  BlocOverrides.runZoned(
    () {},
    blocObserver: AppBlocObserver(),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await sl.allReady();
  await sl.get<AppConfig>().load();

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ru'),
      ],
      path: translationsPath,
      fallbackLocale: const Locale('en', 'US'),
      useOnlyLangCode: true,
      child: MyApp(),
      assetLoader: const CodegenLoader(),
    ),
  );
}
