import 'package:maxi_library/maxi_library.dart';

export 'package:maxi_library_db_sqlite/maxi_library_db_sqlite.dart';

class ReflectByMaxiLibraryDbSqliteImplementation extends Reflectable {
  const ReflectByMaxiLibraryDbSqliteImplementation()
      : super(
          invokingCapability,
          declarationsCapability,
          typeCapability,
          typingCapability,
          typeRelationsCapability,
          subtypeQuantifyCapability,
          reflectedTypeCapability,
        );
}

const reflectByMaxiLibraryDbSqlite = ReflectByMaxiLibraryDbSqliteImplementation();
void main(List<String> args) {}
