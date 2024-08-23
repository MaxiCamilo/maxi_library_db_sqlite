import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/condition_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/sqlite_command_package.dart';

mixin DeleteCommandAdapterSqlite {
  static SqliteCommandPackage convertToPackage({required DeleteCommand command}) {
    final buffer = StringBuffer('DELETE FROM "${command.tableName}"');
    final shieldedValues = [];

    if (command.conditions.isNotEmpty) {
      buffer.write('\n WHERE ');
      final conditionTexts = <String>[];

      for (final item in command.conditions) {
        final result = ConditionCommandAdapterSqlite.convertToPackage(command: item);
        conditionTexts.add(result.commandText);
        shieldedValues.addAll(result.shieldedValues);
      }

      final allConditions = TextUtilities.generateCommand(list: conditionTexts, character: ' AND \n');
      buffer.write(allConditions);
    }

    buffer.write(';');

    return SqliteCommandPackage(commandText: buffer.toString(), shieldedValues: shieldedValues);
  }
}
