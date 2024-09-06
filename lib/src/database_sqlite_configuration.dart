import 'package:maxi_library/maxi_library.dart';
import 'package:maxi_library_db/maxi_library_db.dart';
import 'package:maxi_library_db_sqlite/maxi_library_db_sqlite.dart';

@reflect
class DatabaseSqliteConfiguration with IDataBaseConfiguration {
  @CheckTextLength(minimum: 4, maximum: 515)
  String fileDirection = '';

  @CheckNumberRange(minimum: 0)
  int openConnectionSeconds = 30;

  DatabaseSqliteConfiguration();

  @override
  DataBaseEngineSqlite generateEngine() {
    return DataBaseEngineSqlite(configuration: this);
  }
}
