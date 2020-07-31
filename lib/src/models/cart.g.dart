// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cart _$CartFromJson(Map<String, dynamic> json) {
  return Cart(
    cartList: (json['cartList'] as Map<String, dynamic>)?.map(
      (k, e) => MapEntry(int.parse(k), e as int),
    ),
  );
}

Map<String, dynamic> _$CartToJson(Cart instance) => <String, dynamic>{
      'cartList': instance.cartList?.map((k, e) => MapEntry(k.toString(), e)),
    };
