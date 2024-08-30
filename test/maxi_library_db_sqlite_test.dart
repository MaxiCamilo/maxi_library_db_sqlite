@Timeout(Duration(minutes: 30))
library;

import 'dart:developer';
import 'dart:math' as math;

import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_sqlite/src/reflection/reflection_implementation.dart';
import 'package:test/test.dart';

import 'models/maxi_library_db_sqlite_test_reflector.dart';
import 'models/reflector_test.dart';

class _ReflectorsCatalog extends ReflectorsCatalog {
  @override
  List<ReflectorInstance> get instances => const [MaxiLibraryDbSqliteReflector(), MaxiLibraryDbSqliteTestReflector()];
  const _ReflectorsCatalog();
}

void main() {
  late final dataBase = DatabaseSqliteConfiguration()..fileDirection = '${DirectoryUtilities.prefixRouteLocal}/test.db';

  group('Test sqlite', () {
    setUp(() {
      _ReflectorsCatalog().initializeReflectable();
    });

    test('Test reflection', () {
      final jsonText = '{"openConnectionSeconds":10,"fileDirection":"${DirectoryUtilities.prefixRouteLocal}/test.db"}';

      final conf = ReflectionManager.getReflectionEntity(DatabaseSqliteConfiguration).interpretationFromJson(rawJson: jsonText);

      log(ReflectionManager.getReflectionEntity(DatabaseSqliteConfiguration).serializeToJson(value: conf));
    });

    test('Create database', () async {
      final engine = dataBase.generateEngine();
      await engine.reserveEngine(function: (_) async {});
      await Future.delayed(Duration(seconds: 40));
    });

    test('Create table', () async {
      final command = CreateTableCommand(
        name: 'super_persons',
        columns: [
          ColumnAttributes(nameColumn: 'code', type: ColumnAttributesType.int64, isPrimaryKey: true, isAutoIncrement: true),
          ColumnAttributes(nameColumn: 'firstName', type: ColumnAttributesType.text),
          ColumnAttributes(nameColumn: 'lastName', type: ColumnAttributesType.text),
          ColumnAttributes(nameColumn: 'isAdmin', type: ColumnAttributesType.boolean),
          ColumnAttributes(nameColumn: 'description', type: ColumnAttributesType.text),
        ],
        primaryKeyGroups: [],
        uniqueKeyGroups: [
          ['firstName', 'lastName']
        ],
        foreignKeys: [],
      );

      final engine = dataBase.generateEngine();

      if (await engine.checkTableExists(tableName: command.name)) {
        await engine.deleteTable(tableName: command.name);
      }

      await engine.executeCommand(command: command);
    });

    test('Create foreign key', () async {
      final command = CreateTableCommand(
        name: 'villains',
        columns: [
          ColumnAttributes(nameColumn: 'codeperson', type: ColumnAttributesType.int64, isPrimaryKey: true),
          ColumnAttributes(nameColumn: 'evillevel', type: ColumnAttributesType.decimal),
        ],
        primaryKeyGroups: [],
        uniqueKeyGroups: [],
        foreignKeys: [
          ForeignKey(fieldName: 'codeperson', tableName: 'super_persons', referenceFieldName: 'code'),
        ],
      );

      final engine = dataBase.generateEngine();

      if (await engine.checkTableExists(tableName: command.name)) {
        await engine.deleteTable(tableName: command.name);
      }

      await engine.executeCommand(command: command);
    });

    test('Test adding items', () async {
      final engine = dataBase.generateEngine();

      await engine.executeCommand(command: DeleteCommand(tableName: 'villains'));
      await engine.executeCommand(command: DeleteCommand(tableName: 'super_persons'));

      IDataBaseCommand command = AggregatorCommand(
        tableName: 'super_persons',
        dataField: {'code': 45, 'firstName': 'Maxi', 'lastName': 'Camilo', 'isAdmin': true, 'description': 'The master developer who doesn\'t know English'},
      );

      await engine.executeCommand(command: command);

      command = AggregatorCommand(
        tableName: 'villains',
        dataField: {'codeperson': 45, 'evillevel': 101},
      );

      await engine.executeCommand(command: command);
    });

    test('test add many items', () async {
      final engine = dataBase.generateEngine();

      if (!await engine.checkTableExists(tableName: 'many_items')) {
        await engine.executeCommand(
          command: CreateTableCommand(
            name: 'many_items',
            columns: [
              ColumnAttributes(nameColumn: 'id', type: ColumnAttributesType.int64, isPrimaryKey: true, isAutoIncrement: true),
              ColumnAttributes(nameColumn: 'group', type: ColumnAttributesType.int32),
              ColumnAttributes(nameColumn: 'name', type: ColumnAttributesType.text),
              ColumnAttributes(nameColumn: 'price', type: ColumnAttributesType.decimal),
            ],
            primaryKeyGroups: [],
            uniqueKeyGroups: [],
            foreignKeys: [],
          ),
        );
      }

      final random = math.Random();

      await engine.executeFunctionAsTransaction(function: (instance) async {
        int i = 0;
        int group = 1;
        while (i < 1000000) {
          final list = List.generate(
              10000,
              (position) => {
                    'name': 'Person N° $position (group N° $group)',
                    'price': random.nextInt(1000000),
                    'group': group,
                  });

          group += 1;
          i += list.length;

          for (final item in list) {
            await instance.executeCommand(command: AggregatorCommand(tableName: 'many_items', dataField: item));
          }
        }

        return true;
      });
    });

    test('Select specific elements', () async {
      final engine = dataBase.generateEngine();

      final command = QueryCommand(
        selectedTables: [QueryTable(fieldName: 'many_items')],
        selectedFields: [
          QueryField(fieldName: 'id', type: QueryFieldType.count, nickName: 'cantidad'),
          QueryField(fieldName: 'id', type: QueryFieldType.sum, nickName: 'suma'),
          QueryField(fieldName: 'id', type: QueryFieldType.maximum, nickName: 'maximo'),
          QueryField(fieldName: 'id', type: QueryFieldType.minimum, nickName: 'minimo'),
          QueryField(fieldName: 'id', type: QueryFieldType.average, nickName: 'promedio'),
        ],
        conditions: [
          CompareValue(originField: 'id', value: 5, typeComparation: ConditionCompareType.greaterEqual),
          CompareValue(originField: 'id', value: 15, typeComparation: ConditionCompareType.lessEqual),
        ],
        limit: 10,
        orders: [
          QueryOrder(fields: ['id'], isAscendent: false)
        ],
      );

      final table = await engine.executeQuery(command: command);
      log(table.toString());
    });

    test('Test stream table', () async {
      final engine = dataBase.generateEngine();
      final table = DatabaseTableOperator(
        engine: engine,
        tableName: 'many_items',
        columns: [
          ColumnAttributes(nameColumn: 'id', type: ColumnAttributesType.int64, isPrimaryKey: true, isAutoIncrement: true),
          ColumnAttributes(nameColumn: 'group', type: ColumnAttributesType.int32),
          ColumnAttributes(nameColumn: 'name', type: ColumnAttributesType.text),
          ColumnAttributes(nameColumn: 'price', type: ColumnAttributesType.decimal),
        ],
      );

      await table.initialize();

      await table.querys
          .streamValues(
        minimun: 50,
        maximum: 565,
        isAscendant: true,
      )
          .waitFinish(
        reactionItem: (x) {
          log('sent a list with ${x.length} items');
        },
      );
    });

    test('test table operator initializer', () async {
      final engine = dataBase.generateEngine();
      final entity = DatabaseEntityOperator<Person>(engine: engine, tableName: 'v1_employer');
      await entity.initialize();

      await entity.editor.add(
          value: Person()
            ..name = 'Maxi'
            ..age = 28
            ..isBoss = true
            ..salary = 99.99);
    });
  });
}
