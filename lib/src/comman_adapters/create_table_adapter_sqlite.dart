import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_sqlite/src/sqlite_command_package.dart';

mixin CreateTableAdapterSqlite {
  static SqliteCommandPackage convertToPackage({required CreateTableCommand command}) {
    final buffer = StringBuffer('CREATE TABLE ${command.name} (\n');

    for (final col in command.columns) {
      buffer.write(' ${col.nameColumn} ${_convertColumnType(col.type)}, \n');
    }

    for (final pri in command.columns.where((x) => x.isPrimaryKey)) {
      buffer.write(' PRIMARY KEY (${pri.nameColumn})\n');
    }

    for (final uni in command.columns.where((x) => x.isUniqueKey)) {
      buffer.write(' UNIQUE (${uni.nameColumn})\n');
    }

    for (final pri in command.primaryKeyGroups) {
      if (pri.isEmpty) {
        continue;
      }

      buffer.write(' PRIMARY KEY (${TextUtilities.generateCommand(list: pri)})\n');
    }

    for (final uni in command.uniqueKeyGroups) {
      if (uni.isEmpty) {
        continue;
      }

      buffer.write(' UNIQUE (${TextUtilities.generateCommand(list: uni)})\n');
    }

    for (final fore in command.foreignKeys) {
      buffer.write(' FOREIGN KEY(${fore.fieldName}) REFERENCES ${fore.tableName}(${fore.referenceFieldName})\n');
    }

    buffer.write(');');
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
}
