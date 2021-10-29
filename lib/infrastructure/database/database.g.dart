// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class DBTask extends DataClass implements Insertable<DBTask> {
  final int id;
  final String name;
  final DateTime? date;
  final bool isCompleted;
  DBTask(
      {required this.id,
      required this.name,
      this.date,
      required this.isCompleted});
  factory DBTask.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DBTask(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      name: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      date: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}date']),
      isCompleted: const BoolType()
          .mapFromDatabaseResponse(data['${effectivePrefix}is_completed'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || date != null) {
      map['date'] = Variable<DateTime?>(date);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    return map;
  }

  DBTasksCompanion toCompanion(bool nullToAbsent) {
    return DBTasksCompanion(
      id: Value(id),
      name: Value(name),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
      isCompleted: Value(isCompleted),
    );
  }

  factory DBTask.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DBTask(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      date: serializer.fromJson<DateTime?>(json['date']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'date': serializer.toJson<DateTime?>(date),
      'isCompleted': serializer.toJson<bool>(isCompleted),
    };
  }

  DBTask copyWith({int? id, String? name, DateTime? date, bool? isCompleted}) =>
      DBTask(
        id: id ?? this.id,
        name: name ?? this.name,
        date: date ?? this.date,
        isCompleted: isCompleted ?? this.isCompleted,
      );
  @override
  String toString() {
    return (StringBuffer('DBTask(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, date, isCompleted);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DBTask &&
          other.id == this.id &&
          other.name == this.name &&
          other.date == this.date &&
          other.isCompleted == this.isCompleted);
}

class DBTasksCompanion extends UpdateCompanion<DBTask> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime?> date;
  final Value<bool> isCompleted;
  const DBTasksCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.date = const Value.absent(),
    this.isCompleted = const Value.absent(),
  });
  DBTasksCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.date = const Value.absent(),
    this.isCompleted = const Value.absent(),
  }) : name = Value(name);
  static Insertable<DBTask> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime?>? date,
    Expression<bool>? isCompleted,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (date != null) 'date': date,
      if (isCompleted != null) 'is_completed': isCompleted,
    });
  }

  DBTasksCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<DateTime?>? date,
      Value<bool>? isCompleted}) {
    return DBTasksCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime?>(date.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DBTasksCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('date: $date, ')
          ..write('isCompleted: $isCompleted')
          ..write(')'))
        .toString();
  }
}

class $DBTasksTable extends DBTasks with TableInfo<$DBTasksTable, DBTask> {
  final GeneratedDatabase _db;
  final String? _alias;
  $DBTasksTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      typeName: 'TEXT',
      requiredDuringInsert: true);
  final VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<DateTime?> date = GeneratedColumn<DateTime?>(
      'date', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false);
  final VerificationMeta _isCompletedMeta =
      const VerificationMeta('isCompleted');
  late final GeneratedColumn<bool?> isCompleted = GeneratedColumn<bool?>(
      'is_completed', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      defaultConstraints: 'CHECK (is_completed IN (0, 1))',
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [id, name, date, isCompleted];
  @override
  String get aliasedName => _alias ?? 'd_b_tasks';
  @override
  String get actualTableName => 'd_b_tasks';
  @override
  VerificationContext validateIntegrity(Insertable<DBTask> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('is_completed')) {
      context.handle(
          _isCompletedMeta,
          isCompleted.isAcceptableOrUnknown(
              data['is_completed']!, _isCompletedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DBTask map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DBTask.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $DBTasksTable createAlias(String alias) {
    return $DBTasksTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $DBTasksTable dBTasks = $DBTasksTable(this);
  late final TaskDao taskDao = TaskDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dBTasks];
}
