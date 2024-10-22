import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_sqlite/maxi_library_db_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/aggregator_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/create_table_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/delete_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/modifier_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/query_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/sqlite_command_package.dart';
import 'package:sqlite3/sqlite3.dart';

@reflect
class DataBaseEngineSqlite extends DataBaseEngineTemplate {
  final DatabaseSqliteConfiguration configuration;

  late final String fileDirection;

  DataBaseEngineSqlite({required this.configuration}) {
    fileDirection = DirectoryUtilities.interpretPrefix(configuration.fileDirection);
  }

  @override
  bool get inTransaction => _inTransaction;

  Database? _instance;
  Timer? _databaseShutdownWaiter;
  bool _inTransaction = false;

  bool _checkedFileExists = false;

  @override
  Future<void> prepareEngine() async {
    if (_instance != null) {
      _databaseShutdownWaiter?.cancel();
      return;
    }
    await _createFileDB();

    try {
      _instance = sqlite3.open(fileDirection);
    } catch (ex) {
      throw NegativeResult(
        identifier: NegativeResultCodes.externalFault,
        message: tr('An attempt was made to open an SQLite database located at %1, but an error occurred: %2', [fileDirection, ex.toString()]),
        cause: ex,
      );
    }
  }

  Future<void> _createFileDB() async {
    if (_checkedFileExists) {
      return;
    }

    final file = File(fileDirection);

    if (await file.exists()) {
      _checkedFileExists = true;
      return;
    }

    await DirectoryUtilities.writeFileSecured(fileDirection: fileDirection, content: Uint8List(0));
    _checkedFileExists = true;
  }

  @override
  Future<void> releaseEngine() async {
    if (_inTransaction) {
      log('[DataBaseEngineSqlite] DANGER! An attempt to release the database failed due to an active transaction');
      return;
    }

    if (configuration.openConnectionSeconds == 0) {
      _closeDataBase();
    } else {
      _databaseShutdownWaiter = Timer(Duration(seconds: configuration.openConnectionSeconds), _closeDataBase);
    }
  }

  void _closeDataBase() {
    if (_inTransaction) {
      log('[DataBaseEngineSqlite] DANGER! An attempt to close the database failed due to an active transaction');
      return;
    }
    _databaseShutdownWaiter = null;
    if (_instance != null) {
      containErrorLog(detail: tr('Close Database located at %1', [fileDirection]), function: () => _instance!.dispose());
      _instance = null;
    }
  }

  @override
  Future<void> createTransaction() async {
    checkProgrammingFailure(thatChecks: tr('The database instance was created previously'), result: () => _instance != null);

    if (_inTransaction) {
      return;
    }

    _instance!.execute('BEGIN TRANSACTION;');
    _inTransaction = true;
  }

  @override
  Future<void> commitTransaction() async {
    checkProgrammingFailure(thatChecks: tr('The database instance was created previously'), result: () => _instance != null);
    checkProgrammingFailure(thatChecks: tr('The database instance is in a transaction'), result: () => _inTransaction);

    _instance!.execute('COMMIT;');
    _inTransaction = false;
  }

  @override
  Future<void> rollbackTransaction() async {
    checkProgrammingFailure(thatChecks: tr('The database instance was created previously'), result: () => _instance != null);

    if (!_inTransaction) {
      return;
    }

    _instance!.execute('ROLLBACK;');
    _inTransaction = false;
  }

  @override
  Future<TableResult> executeQueryDirectly({required QueryCommand command}) async {
    final package = QueryCommandAdapterSqlite.convertToPackage(command: command);
    return executeQueryPackage(package);
  }

  void executeDirectCommand(SqliteCommandPackage package) {
    checkProgrammingFailure(thatChecks: tr('The database instance was created previously'), result: () => _instance != null);
    try {
      _instance!.execute(package.commandText, serializeListToDatabase(package.shieldedValues));
    } catch (ex) {
      throw NegativeResult(
        identifier: NegativeResultCodes.externalFault,
        message: tr('The execution of a command in the database failed, the error was: %1', [ex.toString()]),
        cause: ex,
      );
    }
  }

  TableResult executeQueryPackage(SqliteCommandPackage package) {
    checkProgrammingFailure(thatChecks: tr('The database instance was created previously'), result: () => _instance != null);
    try {
      final result = _instance!.select(package.commandText, serializeListToDatabase(package.shieldedValues));
      return TableResult(columnsName: result.columnNames, values: result.rows);
    } catch (ex) {
      throw NegativeResult(
        identifier: NegativeResultCodes.externalFault,
        message: tr('The execution of a query in the database failed, the error was: %1', [ex.toString()]),
        cause: ex,
      );
    }
  }

  void executePackage(SqliteCommandPackage package) {
    checkProgrammingFailure(thatChecks: tr('The database instance was created previously'), result: () => _instance != null);
    try {
      _instance!.execute(package.commandText, serializeListToDatabase(package.shieldedValues));
    } catch (ex) {
      throw NegativeResult(
        identifier: NegativeResultCodes.externalFault,
        message: tr('The execution of a command in the database failed, the error was: %1', [ex.toString()]),
        cause: ex,
      );
    }
  }

  @override
  serializeToDatabase(item) {
    if (item is DateTime) {
      return ConverterUtilities.toInt(value: item);
    }
    if (item is List<int>) {
      return item;
    }

    return ReflectionUtilities.primitiveClone(item);
  }

  @override
  Future<List<String>> getTableColumnsNameDirectly({required String tableName}) async {
    final commandText = 'PRAGMA table_info($tableName);';
    checkProgrammingFailure(thatChecks: tr('The database instance was created previously'), result: () => _instance != null);

    final table = executeQueryPackage(SqliteCommandPackage(commandText: commandText, shieldedValues: []));

    if (table.isEmpty) {
      return [];
    }

    return table.getColumnContentByName(columnName: 'name').cast<String>();
  }

  @override
  Future<bool> checkTableExistsDirectly({required String tableName}) async {
    final commandText = 'SELECT * FROM sqlite_master WHERE type=\'table\' AND name=?;';
    checkProgrammingFailure(thatChecks: tr('The database instance was created previously'), result: () => _instance != null);

    /*
    if (!await checkTableExistsDirectly(tableName: tableName)) {
      throw NegativeResult(
        identifier: NegativeResultCodes.nonExistent,
        message: tr('Table %1 cannot be found', [tableName]),
      );
    }
    */

    final table = executeQueryPackage(SqliteCommandPackage(commandText: commandText, shieldedValues: [tableName]));
    return table.isNotEmpty;
  }

  @override
  Future<void> deleteTableDirectly({required String tableName}) async {
    executePackage(SqliteCommandPackage(commandText: 'DROP TABLE $tableName;', shieldedValues: []));
  }

  @override
  Future<void> executeCommandDirectly({required IDataBaseCommand command}) async {
    if (command is AggregatorCommand) {
      return executePackage(AggregatorCommandAdapterSqlite.convertToPackage(command: command));
    }

    if (command is DeleteCommand) {
      return executePackage(DeleteCommandAdapterSqlite.convertToPackage(command: command));
    }

    if (command is ModifierCommand) {
      return executePackage(ModifierCommandAdapterSqlite.convertToPackage(command: command));
    }

    if (command is CreateTableCommand) {
      if (await checkTableExistsDirectly(tableName: command.name)) {
        throw NegativeResult(
          identifier: NegativeResultCodes.contextInvalidFunctionality,
          message: tr('The %1 table is already defined', [command.name]),
        );
      }

      return executePackage(CreateTableAdapterSqlite.convertToPackage(command: command));
    }

    if (command is QueryCommand) {
      throw NegativeResult(
        identifier: NegativeResultCodes.implementationFailure,
        message: tr('A query command was attempted to be executed within a direct command function'),
      );
    }

    throw NegativeResult(
      identifier: NegativeResultCodes.implementationFailure,
      message: tr('Command type %1 is unknown for the sqlite engine', [command.runtimeType.toString()]),
    );
  }
}
