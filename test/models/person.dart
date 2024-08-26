import 'package:maxi_library/maxi_library.dart';

import 'reflector_test.dart';

@reflector
class Person {
  @PrimaryKey()
  @CheckNumberRange(minimum: 0,maximum: 999)
  int identifier = 0;
  @CheckTextLength(minimum: 3,maximum: 99)
  String name = '';
  @CheckNumberRange(minimum: 18,maximum: 99)
  int age = 0;
  @CheckNumberRange(maximum: 99999)
  double salary = 0;
  @FormalName('is he an idiot?')
  bool isBoss = false;
}
