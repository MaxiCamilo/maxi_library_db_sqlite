@Timeout(Duration(minutes: 30))
library;

import 'package:maxi_library/maxi_library.dart';
import 'package:test/test.dart';

void main() {
  group('Reflection test', () {
    setUp(() {
      // Additional setup goes here.
    });

    test('Generate file reflect', () {
      ReflectorGenerator(directories: ['${DirectoryUtilities.prefixRouteLocal}/lib'], fileCreationPlace: '${DirectoryUtilities.prefixRouteLocal}/lib/src/reflection', albumName: 'MaxiLibraryDbSqlite').build();
    });

    /*

    

    test('Generate reflectors', () async {
      await BuildReflectors.makeFilesReflection(mainFileDirection: 'lib/src/reflection/reflection_implementation.dart');
    });

    test('Generate reflectors test', () async {
      await BuildReflectors.makeFilesReflection(mainFileDirection: 'test/models/reflector_test.dart');
    });
    */
  });
}
