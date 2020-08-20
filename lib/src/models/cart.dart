import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cart.g.dart';

@JsonSerializable()
class Cart extends Equatable {
  final Map<int, int> cartList;

  Cart({this.cartList});

  static Cart fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
  Map<String, dynamic> toJson() => _$CartToJson(this);

  @override
  String toString() {
    return 'Cart { cartList: $cartList }';
  }

  @override
  List<Object> get props => [cartList];
}
