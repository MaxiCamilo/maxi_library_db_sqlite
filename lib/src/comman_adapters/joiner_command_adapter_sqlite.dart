import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';

mixin JoinerCommandAdapterSqlite {
  static String convertJoiner({required QueryJoiner command}) {
    final buffer = StringBuffer();

    buffer.write(switch (command.type) {
      QueryJoinerType.inner => 'INNER JOIN ',
      QueryJoinerType.left => 'LEFT JOIN ',
      QueryJoinerType.rigth => 'RIGTH JOIN ',
      QueryJoinerType.fullOuter => 'FULL OUTER JOIN ',
    });

    late final String table;

    if (command.externalTable.nickName.isEmpty) {
      table = command.externalTable.fieldName;
      buffer.write(table);
    } else {
      table = command.externalTable.nickName;
      buffer.write('"${command.externalTable.fieldName}" AS "${command.externalTable.nickName}"');
    }

    buffer.write(' ON ');

    final conditions = <String>[];

    for (final condition in command.comparers) {
      if (command.originTable.nickName.isEmpty) {
        conditions.add('"${command.originTable.fieldName}"."${condition.originField}" = "$table"."${condition.compareField}"');
      } else {
        conditions.add('"${command.originTable.nickName}"."${condition.originField}" = "$table"."${condition.compareField}"');
      }
    }

    buffer.write(TextUtilities.generateCommand(list: conditions, character: ' AND '));

    return buffer.toString();
  }
}
