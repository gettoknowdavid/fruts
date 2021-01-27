import 'package:fruts/features/cart/domain/entities/cart.dart';
import 'package:fruts/features/crop/data/models/crop_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'cart_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CartModel extends Cart {
  CartModel({
    @required List<CropModel> crops,
    @required Map<int, int> cropsToQuantity,
  }) : super(crops: crops, cropsToQuantity: cropsToQuantity);

  static CartModel fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
  Map<String, dynamic> toJson() => _$CartModelToJson(this);
}
