import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_sqlite/src/database_engine_sqlite.dart';

class DatabaseSqliteConfiguration with IDataBaseConfiguration {
  @CheckTextLength(minimum: 4, maximum: 515)
  String fileDirection = '';

  int openConnectionSeconds = 30;

  DatabaseSqliteConfiguration();

  @override
  IDataBaseEngine generateEngine() {
    return DataBaseEngineSqlite(configuration: this);
  }
}
