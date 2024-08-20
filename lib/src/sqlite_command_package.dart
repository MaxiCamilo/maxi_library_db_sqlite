class SqliteCommandPackage {
  final String commandText;
  final List shieldedValues;

  const SqliteCommandPackage({
    required this.commandText,
    required this.shieldedValues,
  });
}
