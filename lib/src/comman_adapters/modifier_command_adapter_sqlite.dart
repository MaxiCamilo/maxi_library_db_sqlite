import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/condition_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/sqlite_command_package.dart';

mixin ModifierCommandAdapterSqlite {
  static SqliteCommandPackage convertToPackage({required ModifierCommand command}) {
    final shieldedValues = command.dataField.values.toList();
    final buffer = StringBuffer('UPDATE "${command.tableName}" SET \n ');

    final propertyNames = command.dataField.keys.map((x) => '"$x" = ?');
    buffer.write(TextUtilities.generateCommand(list: propertyNames.map((x) => x)));

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
