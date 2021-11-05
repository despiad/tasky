import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/bloc_observer.dart';
import 'package:tasky/injection_container.dart' as sl;

import 'app.dart';

void main() {
  Bloc.observer = AppBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  sl.setup();
  runApp(MyApp());
}
