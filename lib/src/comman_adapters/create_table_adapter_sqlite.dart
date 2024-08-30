import 'dart:developer';

import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_sqlite/src/sqlite_command_package.dart';

mixin CreateTableAdapterSqlite {
  static SqliteCommandPackage convertToPackage({required CreateTableCommand command}) {
    if (command.primaryKeyGroups.isEmpty &&
        command.uniqueKeyGroups.isEmpty &&
        command.foreignKeys.isEmpty &&
        !command.columns.any((x) => x.isPrimaryKey && !x.isAutoIncrement) &&
        !command.columns.any((x) => x.isUniqueKey)) {
      return _convertToSimplePackage(command);
    }

    final buffer = StringBuffer('CREATE TABLE ${command.name} (\n');

    for (final col in command.columns) {
      buffer.write(' "${col.nameColumn}" ${_convertColumnType(col.type)} NOT NULL');
      if (col.isPrimaryKey && col.isAutoIncrement) {
        buffer.write(' PRIMARY KEY AUTOINCREMENT');
      }

      buffer.write(', \n');
    }

    for (final pri in command.columns.where((x) => x.isPrimaryKey && !x.isAutoIncrement)) {
      buffer.write(' PRIMARY KEY (${pri.nameColumn})\n');
    }

    for (final uni in command.columns.where((x) => x.isUniqueKey)) {
      buffer.write(' UNIQUE (${uni.nameColumn})\n');
    }

    for (final pri in command.primaryKeyGroups) {
      if (pri.isEmpty) {
        continue;
      }

      buffer.write(' PRIMARY KEY (${TextUtilities.generateCommand(list: pri.map((x) => '"$x"'))})\n');
    }

    for (final uni in command.uniqueKeyGroups) {
      if (uni.isEmpty) {
        continue;
      }

      buffer.write(' UNIQUE (${TextUtilities.generateCommand(list: uni.map((x) => '"$x"'))})\n');
    }

    for (final fore in command.foreignKeys) {
      buffer.write(' FOREIGN KEY(${fore.fieldName}) REFERENCES ${fore.tableName}(${fore.referenceFieldName})\n');
    }

    buffer.write(');');

    log(buffer.toString());

    return SqliteCommandPackage(commandText: buffer.toString(), shieldedValues: []);
  }

  static String _convertColumnType(ColumnAttributesType type) {
    return switch (type) {
      ColumnAttributesType.text => 'TEXT',
      ColumnAttributesType.boolean => 'NUMERIC',
      ColumnAttributesType.intWithoutLimit => 'INTEGER',
      ColumnAttributesType.int8 => 'INTEGER',
      ColumnAttributesType.int16 => 'INTEGER',
      ColumnAttributesType.int32 => 'INTEGER',
      ColumnAttributesType.int64 => 'INTEGER',
      ColumnAttributesType.uintWithoutLimit => 'INTEGER',
      ColumnAttributesType.uint8 => 'INTEGER',
      ColumnAttributesType.uint16 => 'INTEGER',
      ColumnAttributesType.uint32 => 'INTEGER',
      ColumnAttributesType.uint64 => 'INTEGER',
      ColumnAttributesType.doubleWithoutLimit => 'REAL',
      ColumnAttributesType.decimal => 'REAL',
      ColumnAttributesType.dateTime => 'INTEGER',
      ColumnAttributesType.binary => 'BLOB',
      ColumnAttributesType.dynamicType => 'BLOB',
    };
  }

  static SqliteCommandPackage _convertToSimplePackage(CreateTableCommand command) {
    final buffer = StringBuffer('CREATE TABLE ${command.name} (\n');

    for (final col in command.columns) {
      buffer.write(' "${col.nameColumn}" ${_convertColumnType(col.type)} NOT NULL');
      if (col.isPrimaryKey && col.isAutoIncrement) {
        buffer.write(' PRIMARY KEY AUTOINCREMENT');
      }
      if (col == command.columns.last) {
        buffer.write('\n');
      } else {
        buffer.write(',\n');
      }
    }

    buffer.write(');');

    return SqliteCommandPackage(commandText: buffer.toString(), shieldedValues: []);
  }
}
