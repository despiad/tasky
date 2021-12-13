import 'package:drift/drift.dart';

class DBSettings extends Table {
  TextColumn get locale => text()();
  BoolColumn get isDarkTheme => boolean().withDefault(const Constant(false))();
  BoolColumn get isNotificationsPermitted =>
      boolean().withDefault(const Constant(false))();
}
