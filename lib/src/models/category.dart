import 'package:fruts/src/data/enum_helper.dart';

enum Category { all, exotics, fresh, fruits, nuts, vegetables }

String enumFormatter(dynamic input) {
  final cat = enumToString(input);
  final upperFirst = cat[0].toUpperCase();
  final splitCat = cat.split(cat[0]);
  final category = upperFirst + splitCat[1];
  return category;
}
