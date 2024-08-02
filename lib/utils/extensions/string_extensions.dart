import 'package:intl/intl.dart';

import '../patterns.dart';

bool hasMatch(String? s, String p) {
  return (s == null) ? false : RegExp(p).hasMatch(s);
}

int getExtendedVersionNumber(String version) {
  List versionCells = version.split('.');
  versionCells = versionCells.map((i) => int.parse(i)).toList();
  return versionCells[0] * 100000 + versionCells[1] * 1000 + versionCells[2];
}

extension StringExtension on String{
  int versionNumber() => getExtendedVersionNumber(this);
}

extension CapExtension on String {
  String get inCaps =>
      isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String get allInCaps => toUpperCase();
  String get capitalizeFirstOfEach => replaceAll(RegExp(' +'), ' ')
      .split(" ")
      .map((str) => str.inCaps)
      .join(" ");
  String get camelCase =>
      '${this[0].toLowerCase()}${substring(1).capitalizeFirstOfEach.replaceAll(' ', '')}';
  String get fileExtension =>
      "."+split('.').last;
}

extension RegexExtension on String {
  bool validateEmail() => hasMatch(this, Patterns.email);
  bool validatePhone() => hasMatch(this, Patterns.phone);
  bool validateURL() => hasMatch(this, Patterns.url);
}

dateFormatter({String? format = 'dd-MM-yyyy'}) {
  var now = DateTime.now();
  var formatter = DateFormat(format);
  String formattedDate = formatter.format(now);
  return formattedDate;
}
