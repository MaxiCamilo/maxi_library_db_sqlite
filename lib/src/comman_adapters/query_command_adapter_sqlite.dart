import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/condition_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/joiner_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/sqlite_command_package.dart';

mixin QueryCommandAdapterSqlite {
  static SqliteCommandPackage convertToPackage({required QueryCommand command}) {
    final buffer = StringBuffer();
    final shieldedValues = [];

    buffer.write('SELECT ');

    if (command.selectedFields.isEmpty) {
      buffer.write('*');
    } else {
      _convertSelectFields(command, buffer, shieldedValues);
    }

    buffer.write('\n FROM ');
    _convertSelectedTable(command, buffer, shieldedValues);

    for (final joined in command.joinedTables) {
      buffer.write('\n ${JoinerCommandAdapterSqlite.convertJoiner(command: joined)}');
    }

    if (command.conditions.isNotEmpty) {
      buffer.write('\n WHERE ');
      _convertConditions(command, buffer, shieldedValues);
    }

    if (command.grouped.isNotEmpty) {
      buffer.write('\n GROUP BY ${TextUtilities.generateCommand(list: command.grouped)} ');
    }

    if (command.havings.isNotEmpty) {
      buffer.write('\n HAVING ');
      _convertHavings(command, buffer, shieldedValues);
    }

    if (command.orders.isNotEmpty) {
      _convertOrderBy(command, buffer, shieldedValues);
    }

    if (command.limit != null && command.limit! > 0) {
      buffer.write('\n LIMIT ${command.limit}');
    }

    return SqliteCommandPackage(commandText: buffer.toString(), shieldedValues: shieldedValues);
  }

  static void _convertSelectFields(QueryCommand command, StringBuffer buffer, List shieldedValues) {
    final textsCommands = <String>[];
    for (final field in command.selectedFields) {
      late String text;
      if (field.fieldName == '') {
        text = '*';
      } else if (field.nickName == '') {
        text = field.fieldName;
      } else {
        text = '${field.fieldName} AS ${field.nickName}';
      }

      switch (field.type) {
        case QueryFieldType.field:
          break;
        case QueryFieldType.count:
          text = 'COUNT($text)';
          break;
        case QueryFieldType.maximum:
          text = 'MAX($text)';
          break;
        case QueryFieldType.minimum:
          text = 'MIN($text)';
          break;
        case QueryFieldType.average:
          text = 'AVG($text)';
          break;
      }

      textsCommands.add(text);
    }

    buffer.write(TextUtilities.generateCommand(list: textsCommands));
  }

  static void _convertSelectedTable(QueryCommand command, StringBuffer buffer, List shieldedValues) {
    final textsCommands = <String>[];

    for (final table in command.selectedTables) {
      if (table.nickName.isEmpty) {
        textsCommands.add(table.fieldName);
      } else {
        textsCommands.add('${table.fieldName} AS ${table.nickName}');
      }
    }

    buffer.write(TextUtilities.generateCommand(list: textsCommands));
  }

  static void _convertConditions(QueryCommand command, StringBuffer buffer, List shieldedValues) {
    final textsCommands = <String>[];
    for (final condition in command.conditions) {
      final conv = ConditionCommandAdapterSqlite.convertToPackage(command: condition);
      shieldedValues.addAll(conv.shieldedValues);
    }
    buffer.write(TextUtilities.generateCommand(list: textsCommands, character: ' AND \n'));
  }

  static void _convertHavings(QueryCommand command, StringBuffer buffer, List shieldedValues) {
    final commandTexts = <String>[];
    for (final item in command.havings) {
      final subCommand = ConditionCommandAdapterSqlite.convertToPackage(command: item);
      commandTexts.add(subCommand.commandText);
      shieldedValues.addAll(subCommand.shieldedValues);
    }

    buffer.write(TextUtilities.generateCommand(list: commandTexts, character: ' AND \n'));
  }

  static void _convertOrderBy(QueryCommand command, StringBuffer buffer, List shieldedValues) {
    for (final item in command.orders) {
      buffer.write('\n ORDER BY ${TextUtilities.generateCommand(list: item.fields)} ${item.isAscendent ? 'ASC' : 'DESC'}');
    }
  }
}
