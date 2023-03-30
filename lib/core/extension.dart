extension BoolParsing on String {
  bool parseBool() {
    return toLowerCase() == 'true';
  }
}
extension StringTrim on String {
  bool isEmptyWithTrim() => trim().isEmpty;

  bool isNotEmptyWithTrim() => trim().isNotEmpty;
}
