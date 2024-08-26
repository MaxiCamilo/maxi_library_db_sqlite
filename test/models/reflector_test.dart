import 'package:reflectable/reflectable.dart';

export 'person.dart';

class ReflectorTest extends Reflectable {
  const ReflectorTest()
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

const reflector = ReflectorTest();
void main(List<String> args) {}
