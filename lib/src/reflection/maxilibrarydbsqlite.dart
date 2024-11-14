// ignore_for_file: unnecessary_const, unnecessary_import, duplicate_import, unused_import

import 'package:maxi_library/export_reflectors.dart';
import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_sqlite/maxi_library_db_sqlite.dart';
import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:maxi_library_db_sqlite/src/comman_adapters/aggregator_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/create_table_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/delete_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/modifier_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/query_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/sqlite_command_package.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/condition_command_adapter_sqlite.dart';
import 'package:maxi_library_db_sqlite/src/comman_adapters/joiner_command_adapter_sqlite.dart';



/*----------------------------------   Class DatabaseSqliteConfiguration   ----------------------------------*/


/*DATABASESQLITECONFIGURATION FIELDS*/

class _DatabaseSqliteConfigurationfileDirection extends GeneratedReflectedField<DatabaseSqliteConfiguration,String> with GeneratedReflectedModifiableField<DatabaseSqliteConfiguration,String> {
const _DatabaseSqliteConfigurationfileDirection();
@override
List get annotations => const [CheckTextLength(minimum: 4, maximum: 515)];

@override
String get name => 'fileDirection';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
String? get defaulValue => '';

@override
String getReservedValue({required DatabaseSqliteConfiguration? entity}) =>
entity!.fileDirection;
@override
void setReservedValue({required DatabaseSqliteConfiguration? entity, required String newValue}) =>
	entity!.fileDirection = newValue;
}

class _DatabaseSqliteConfigurationopenConnectionSeconds extends GeneratedReflectedField<DatabaseSqliteConfiguration,int> with GeneratedReflectedModifiableField<DatabaseSqliteConfiguration,int> {
const _DatabaseSqliteConfigurationopenConnectionSeconds();
@override
List get annotations => const [CheckNumberRange(minimum: 0)];

@override
String get name => 'openConnectionSeconds';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => false;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => true;
@override
int? get defaulValue => 30;

@override
int getReservedValue({required DatabaseSqliteConfiguration? entity}) =>
entity!.openConnectionSeconds;
@override
void setReservedValue({required DatabaseSqliteConfiguration? entity, required int newValue}) =>
	entity!.openConnectionSeconds = newValue;
}

/*DATABASESQLITECONFIGURATION METHODS*/

class _DatabaseSqliteConfigurationgenerateEngineMethod extends GeneratedReflectedMethod<DatabaseSqliteConfiguration, DataBaseEngineSqlite> {
const _DatabaseSqliteConfigurationgenerateEngineMethod();
@override
String get name => 'generateEngine';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
DataBaseEngineSqlite callReservedMethod({required DatabaseSqliteConfiguration? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.generateEngine();
}


class _DatabaseSqliteConfigurationBuilder extends GeneratedReflectedMethod<DatabaseSqliteConfiguration, DatabaseSqliteConfiguration> {
const _DatabaseSqliteConfigurationBuilder();
@override
String get name => '';

@override
bool get isStatic => true;

@override
MethodDetectedType get methodType => MethodDetectedType.buildMethod;

@override
List get annotations => const [];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
DatabaseSqliteConfiguration callReservedMethod({required DatabaseSqliteConfiguration? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
DatabaseSqliteConfiguration();
}


/*DATABASESQLITECONFIGURATION INSTANCE*/

class _DatabaseSqliteConfiguration extends GeneratedReflectedClass<DatabaseSqliteConfiguration> {
const _DatabaseSqliteConfiguration();
@override
List get annotations => const [reflect];

@override
Type? get baseClass => null;

@override
List<Type> get classThatImplement => const [IDataBaseConfiguration];

@override
bool get isAbstract => false;

@override
bool get isMixin => false;

@override
String get name => 'DatabaseSqliteConfiguration';

@override
List<GeneratedReflectedMethod> get methods => const [_DatabaseSqliteConfigurationgenerateEngineMethod(),_DatabaseSqliteConfigurationBuilder()];

@override
List<GeneratedReflectedField> get fields => const [_DatabaseSqliteConfigurationfileDirection(),_DatabaseSqliteConfigurationopenConnectionSeconds()];


}
/*----------------------------------   x   ----------------------------------*/



/*----------------------------------   Class DataBaseEngineSqlite   ----------------------------------*/


/*DATABASEENGINESQLITE FIELDS*/

class _DataBaseEngineSqliteconfiguration extends GeneratedReflectedField<DataBaseEngineSqlite,DatabaseSqliteConfiguration>{
const _DataBaseEngineSqliteconfiguration();
@override
List get annotations => const [];

@override
String get name => 'configuration';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => false;

@override
bool get isFinal => true;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => false;
@override
DatabaseSqliteConfiguration? get defaulValue => null;

@override
DatabaseSqliteConfiguration getReservedValue({required DataBaseEngineSqlite? entity}) =>
entity!.configuration;
}

class _DataBaseEngineSqlitefileDirection extends GeneratedReflectedField<DataBaseEngineSqlite,FileOperatorNative> with GeneratedReflectedModifiableField<DataBaseEngineSqlite,FileOperatorNative> {
const _DataBaseEngineSqlitefileDirection();
@override
List get annotations => const [];

@override
String get name => 'fileDirection';

@override
bool get isStatic => false;

@override
bool get isConst => false;

@override
bool get isLate => true;

@override
bool get isFinal => true;

@override
bool get acceptNull => false;

@override
bool get hasDefaultValue => false;
@override
FileOperatorNative? get defaulValue => null;

@override
FileOperatorNative getReservedValue({required DataBaseEngineSqlite? entity}) =>
entity!.fileDirection;
@override
void setReservedValue({required DataBaseEngineSqlite? entity, required FileOperatorNative newValue}) =>
	entity!.fileDirection = newValue;
}

/*DATABASEENGINESQLITE METHODS*/

class _DataBaseEngineSqliteinTransactionGetter extends GeneratedReflectedMethod<DataBaseEngineSqlite, bool> {
const _DataBaseEngineSqliteinTransactionGetter();
@override
String get name => 'inTransaction';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.getMehtod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
bool callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.inTransaction;
}


class _DataBaseEngineSqliteprepareEngineMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, Future<void>> {
const _DataBaseEngineSqliteprepareEngineMethod();
@override
String get name => 'prepareEngine';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
Future<void> callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.prepareEngine();
}


class _DataBaseEngineSqlitereleaseEngineMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, Future<void>> {
const _DataBaseEngineSqlitereleaseEngineMethod();
@override
String get name => 'releaseEngine';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
Future<void> callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.releaseEngine();
}


class _DataBaseEngineSqlitecreateTransactionMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, Future<void>> {
const _DataBaseEngineSqlitecreateTransactionMethod();
@override
String get name => 'createTransaction';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
Future<void> callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.createTransaction();
}


class _DataBaseEngineSqlitecommitTransactionMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, Future<void>> {
const _DataBaseEngineSqlitecommitTransactionMethod();
@override
String get name => 'commitTransaction';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
Future<void> callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.commitTransaction();
}


class _DataBaseEngineSqliterollbackTransactionMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, Future<void>> {
const _DataBaseEngineSqliterollbackTransactionMethod();
@override
String get name => 'rollbackTransaction';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
Future<void> callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.rollbackTransaction();
}


class _DataBaseEngineSqliteexecuteQueryDirectlyMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, Future<TableResult>> {
const _DataBaseEngineSqliteexecuteQueryDirectlyMethod();
@override
String get name => 'executeQueryDirectly';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namcommand = GeneratedReflectedNamedParameter<QueryCommand>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'command',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namcommand];

@override
Future<TableResult> callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.executeQueryDirectly(command: _namcommand.getValueFromMap(namedValues),);
}


class _DataBaseEngineSqliteexecuteDirectCommandMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, dynamic> {
const _DataBaseEngineSqliteexecuteDirectCommandMethod();
@override
String get name => 'executeDirectCommand';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [];

static const _fix0 = GeneratedReflectedFixedParameter<SqliteCommandPackage>(
      annotations: const [],
      name: 'package',
      position: 0,
      hasDefaultValue: false,
      defaultValue: null,
      acceptNulls: false,
    )
;
@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [_fix0];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
dynamic callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.executeDirectCommand(_fix0.getValueFromList(fixedValues),);
}


class _DataBaseEngineSqliteexecuteQueryPackageMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, TableResult> {
const _DataBaseEngineSqliteexecuteQueryPackageMethod();
@override
String get name => 'executeQueryPackage';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [];

static const _fix0 = GeneratedReflectedFixedParameter<SqliteCommandPackage>(
      annotations: const [],
      name: 'package',
      position: 0,
      hasDefaultValue: false,
      defaultValue: null,
      acceptNulls: false,
    )
;
@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [_fix0];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
TableResult callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.executeQueryPackage(_fix0.getValueFromList(fixedValues),);
}


class _DataBaseEngineSqliteexecutePackageMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, dynamic> {
const _DataBaseEngineSqliteexecutePackageMethod();
@override
String get name => 'executePackage';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [];

static const _fix0 = GeneratedReflectedFixedParameter<SqliteCommandPackage>(
      annotations: const [],
      name: 'package',
      position: 0,
      hasDefaultValue: false,
      defaultValue: null,
      acceptNulls: false,
    )
;
@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [_fix0];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
dynamic callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.executePackage(_fix0.getValueFromList(fixedValues),);
}


class _DataBaseEngineSqliteserializeToDatabaseMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, dynamic> {
const _DataBaseEngineSqliteserializeToDatabaseMethod();
@override
String get name => 'serializeToDatabase';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _fix0 = GeneratedReflectedFixedParameter<dynamic>(
      annotations: const [],
      name: 'item',
      position: 0,
      hasDefaultValue: false,
      defaultValue: null,
      acceptNulls: false,
    )
;
@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [_fix0];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [];

@override
dynamic callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.serializeToDatabase(_fix0.getValueFromList(fixedValues),);
}


class _DataBaseEngineSqlitegetTableColumnsNameDirectlyMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, Future<List<String>>> {
const _DataBaseEngineSqlitegetTableColumnsNameDirectlyMethod();
@override
String get name => 'getTableColumnsNameDirectly';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namtableName = GeneratedReflectedNamedParameter<String>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'tableName',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namtableName];

@override
Future<List<String>> callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.getTableColumnsNameDirectly(tableName: _namtableName.getValueFromMap(namedValues),);
}


class _DataBaseEngineSqlitecheckTableExistsDirectlyMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, Future<bool>> {
const _DataBaseEngineSqlitecheckTableExistsDirectlyMethod();
@override
String get name => 'checkTableExistsDirectly';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namtableName = GeneratedReflectedNamedParameter<String>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'tableName',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namtableName];

@override
Future<bool> callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.checkTableExistsDirectly(tableName: _namtableName.getValueFromMap(namedValues),);
}


class _DataBaseEngineSqlitedeleteTableDirectlyMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, Future<void>> {
const _DataBaseEngineSqlitedeleteTableDirectlyMethod();
@override
String get name => 'deleteTableDirectly';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namtableName = GeneratedReflectedNamedParameter<String>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'tableName',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namtableName];

@override
Future<void> callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.deleteTableDirectly(tableName: _namtableName.getValueFromMap(namedValues),);
}


class _DataBaseEngineSqliteexecuteCommandDirectlyMethod extends GeneratedReflectedMethod<DataBaseEngineSqlite, Future<void>> {
const _DataBaseEngineSqliteexecuteCommandDirectlyMethod();
@override
String get name => 'executeCommandDirectly';

@override
bool get isStatic => false;

@override
MethodDetectedType get methodType => MethodDetectedType.commonMethod;

@override
List get annotations => const [override];

static const _namcommand = GeneratedReflectedNamedParameter<IDataBaseCommand>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'command',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namcommand];

@override
Future<void> callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
entity!.executeCommandDirectly(command: _namcommand.getValueFromMap(namedValues),);
}


class _DataBaseEngineSqliteBuilder extends GeneratedReflectedMethod<DataBaseEngineSqlite, DataBaseEngineSqlite> {
const _DataBaseEngineSqliteBuilder();
@override
String get name => '';

@override
bool get isStatic => true;

@override
MethodDetectedType get methodType => MethodDetectedType.buildMethod;

@override
List get annotations => const [];

static const _namconfiguration = GeneratedReflectedNamedParameter<dynamic>(
      annotations: const [],
      defaultValue: null,
      hasDefaultValue: false,
      acceptNulls: false,
      name: 'configuration',
)
;@override
List<GeneratedReflectedFixedParameter> get fixedParameters => const [];

@override
List<GeneratedReflectedNamedParameter> get namedParameters => const [_namconfiguration];

@override
DataBaseEngineSqlite callReservedMethod({required DataBaseEngineSqlite? entity, required List fixedValues, required Map<String, dynamic> namedValues}) =>
DataBaseEngineSqlite(configuration: _namconfiguration.getValueFromMap(namedValues),);
}


/*DATABASEENGINESQLITE INSTANCE*/

class _DataBaseEngineSqlite extends GeneratedReflectedClass<DataBaseEngineSqlite> {
const _DataBaseEngineSqlite();
@override
List get annotations => const [reflect];

@override
Type? get baseClass => DataBaseEngineTemplate;

@override
List<Type> get classThatImplement => const [];

@override
bool get isAbstract => false;

@override
bool get isMixin => false;

@override
String get name => 'DataBaseEngineSqlite';

@override
List<GeneratedReflectedMethod> get methods => const [_DataBaseEngineSqliteinTransactionGetter(),_DataBaseEngineSqliteprepareEngineMethod(),_DataBaseEngineSqlitereleaseEngineMethod(),_DataBaseEngineSqlitecreateTransactionMethod(),_DataBaseEngineSqlitecommitTransactionMethod(),_DataBaseEngineSqliterollbackTransactionMethod(),_DataBaseEngineSqliteexecuteQueryDirectlyMethod(),_DataBaseEngineSqliteexecuteDirectCommandMethod(),_DataBaseEngineSqliteexecuteQueryPackageMethod(),_DataBaseEngineSqliteexecutePackageMethod(),_DataBaseEngineSqliteserializeToDatabaseMethod(),_DataBaseEngineSqlitegetTableColumnsNameDirectlyMethod(),_DataBaseEngineSqlitecheckTableExistsDirectlyMethod(),_DataBaseEngineSqlitedeleteTableDirectlyMethod(),_DataBaseEngineSqliteexecuteCommandDirectlyMethod(),_DataBaseEngineSqliteBuilder()];

@override
List<GeneratedReflectedField> get fields => const [_DataBaseEngineSqliteconfiguration(),_DataBaseEngineSqlitefileDirection()];


}
/*----------------------------------   x   ----------------------------------*/



class _AlbumMaxiLibraryDbSqlite extends GeneratedReflectorAlbum {
  const _AlbumMaxiLibraryDbSqlite();
  @override
  List<GeneratedReflectedClass> get classes => const [_DatabaseSqliteConfiguration(),_DataBaseEngineSqlite()];

  @override
  List<TypeEnumeratorReflector> get enums => const [];
}


const maxiLibraryDbSqliteReflectors = _AlbumMaxiLibraryDbSqlite();
