import 'package:flutter/material.dart';
import 'package:tasky/injection_container.dart' as sl;

import 'app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  sl.setup();
  runApp(MyApp());
}
