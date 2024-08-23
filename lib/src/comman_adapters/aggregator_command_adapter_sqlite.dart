import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_sqlite/src/sqlite_command_package.dart';

mixin AggregatorCommandAdapterSqlite {
  static SqliteCommandPackage convertToPackage({required AggregatorCommand command}) {
    final buffer = StringBuffer('INSERT INTO "${command.tableName}" (');
    buffer.write(TextUtilities.generateCommand(list: command.fieldData.keys, function: (p0) => '"$p0"'));
    buffer.write(') VALUES (');
    buffer.write(TextUtilities.generateCommand(list: command.fieldData.keys, function: (p0) => '?'));
    buffer.write(');');

    return SqliteCommandPackage(commandText: buffer.toString(), shieldedValues: command.fieldData.values.toList());
  }
}
