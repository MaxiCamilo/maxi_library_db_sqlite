import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_sqlite/src/sqlite_command_package.dart';

mixin ConditionCommandAdapterSqlite {
  static SqliteCommandPackage convertToPackage({required IConditionQuery command}) {
    return switch (command.runtimeType) {
      const (CompareValue) => _convertCompareValue(command as CompareValue),
      const (CompareFields) => _convertField(command as CompareFields),
      const (CompareIncludesValues) => _convertIncludeValues(command as CompareIncludesValues),
      const (CompareMultipleComparisons) => _convertToMultipleComparisons(command as CompareMultipleComparisons),
      const (CompareSimilarText) => _convertSimilarText(command as CompareSimilarText),
      _ => throw NegativeResult(identifier: NegativeResultCodes.implementationFailure, message: tr('Condition type is unkowned')),
    };
  }

  //Ex: name = 'Maxi' (or shieldValue == true: name = ?)
  static SqliteCommandPackage _convertCompareValue(CompareValue command) {
    final generalCommandText = '"${command.originField}" ${convertConditionCompareToText(command.typeComparation)} ';

    if (command.shieldValue) {
      return SqliteCommandPackage(commandText: '$generalCommandText ?', shieldedValues: [command.value]);
    } else {
      final textualValue = command.value is String ? '\'${command.value}\'' : command.value.toString();
      return SqliteCommandPackage(commandText: '$generalCommandText $textualValue', shieldedValues: [command.value]);
    }
  }

  static SqliteCommandPackage _convertField(CompareFields command) {
    return SqliteCommandPackage(commandText: '"${command.originField}" ${convertConditionCompareToText(command.typeComparation)} "${command.compareField}"', shieldedValues: []);
  }

  static SqliteCommandPackage _convertIncludeValues(CompareIncludesValues command) {
    final buffer = StringBuffer();

    if (command.isInclusive) {
      buffer.write('IN (');
    } else {
      buffer.write('NOT IN (');
    }

    if (command.shieldValue) {
      buffer.write(TextUtilities.generateCommand(list: List.generate(command.options.length, (_) => '?')));
    } else {
      buffer.write(TextUtilities.generateCommand(list: command.options.map((x) => x is String ? '\'$x\'' : x.toString())));
    }

    buffer.write(')');
    return SqliteCommandPackage(commandText: buffer.toString(), shieldedValues: command.shieldValue ? command.options : []);
  }

  static SqliteCommandPackage _convertToMultipleComparisons(CompareMultipleComparisons command) {
    final buffer = StringBuffer('(');
    final shieldedValues = [];

    for (final cond in command.conditions) {
      final gener = convertToPackage(command: cond);
      buffer.write(gener.commandText);
      shieldedValues.addAll(gener.shieldedValues);
      if (cond != command.conditions.last) {
        buffer.write(command.typeComparation == CompareMultipleComparisonsLogic.and ? ' AND ' : ' OR ');
      }
    }

    buffer.write(')');
    return SqliteCommandPackage(commandText: buffer.toString(), shieldedValues: shieldedValues);
  }

  static SqliteCommandPackage _convertSimilarText(CompareSimilarText command) {
    if (command.shieldValue) {
      return SqliteCommandPackage(commandText: '"${command.fieldName}" LIKE ?', shieldedValues: [command.similarText]);
    } else {
      return SqliteCommandPackage(commandText: '"${command.fieldName}" LIKE \'${command.similarText}\'', shieldedValues: []);
    }
  }

  static String convertConditionCompareToText(ConditionCompareType type) {
    return switch (type) {
      ConditionCompareType.equal => '=',
      ConditionCompareType.notEqual => '<>',
      ConditionCompareType.greater => '>',
      ConditionCompareType.less => '<',
      ConditionCompareType.greaterEqual => '>=',
      ConditionCompareType.lessEqual => '<=',
    };
  }
}
