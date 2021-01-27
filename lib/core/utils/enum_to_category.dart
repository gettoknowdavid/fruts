import './enum_to_string.dart';

String enumFormatter(dynamic input) {
  final cat = enumToString(input);
  final upperFirst = cat[0].toUpperCase();
  final splitCat = cat.split(cat[0]);
  final category = upperFirst + splitCat[1];
  return category;
}


