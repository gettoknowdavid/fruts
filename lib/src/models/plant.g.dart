// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Plant _$PlantFromJson(Map<String, dynamic> json) {
  return Plant(
    id: json['id'] as int,
    name: json['name'] as String,
    genus: json['genus'] as String,
    category: _$enumDecodeNullable(_$CategoryEnumMap, json['category']),
    nutritions: (json['nutritions'] as List)
        ?.map((e) => (e as Map<String, dynamic>)?.map(
              (k, e) => MapEntry(
                  _$enumDecodeNullable(_$NutritionTypeEnumMap, k),
                  (e as num)?.toDouble()),
            ))
        ?.toList(),
    price: (json['price'] as num)?.toDouble(),
    image: json['image'] as String,
    rating: (json['rating'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$PlantToJson(Plant instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'genus': instance.genus,
      'category': _$CategoryEnumMap[instance.category],
      'nutritions': instance.nutritions
          ?.map((e) => e?.map((k, e) => MapEntry(_$NutritionTypeEnumMap[k], e)))
          ?.toList(),
      'price': instance.price,
      'image': instance.image,
      'rating': instance.rating,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$CategoryEnumMap = {
  Category.all: 'all',
  Category.exotics: 'exotics',
  Category.fresh: 'fresh',
  Category.fruits: 'fruits',
  Category.nuts: 'nuts',
  Category.vegetables: 'vegetables',
};

const _$NutritionTypeEnumMap = {
  NutritionType.carbohydates: 'carbohydates',
  NutritionType.protein: 'protein',
  NutritionType.fat: 'fat',
  NutritionType.calories: 'calories',
  NutritionType.sugar: 'sugar',
};
