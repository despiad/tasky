import 'package:drift/drift.dart';

class DBSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();
  TextColumn get locale => text().withDefault(const Constant('en'))();
  BoolColumn get isDarkTheme => boolean().withDefault(const Constant(false))();
  BoolColumn get isNotificationsPermitted =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column>? get primaryKey => {id};
}
