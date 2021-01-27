// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartModel _$CartModelFromJson(Map<String, dynamic> json) {
  return CartModel(
    crops: (json['crops'] as List)
        ?.map((e) =>
            e == null ? null : CropModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    cropsToQuantity: (json['cropsToQuantity'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e as int),
    ),
  );
}

Map<String, dynamic> _$CartModelToJson(CartModel instance) => <String, dynamic>{
      'crops': instance.crops?.map((e) => e?.toJson())?.toList(),
      'cropsToQuantity':
          instance.cropsToQuantity?.map((k, e) => MapEntry(k.toString(), e)),
    };
