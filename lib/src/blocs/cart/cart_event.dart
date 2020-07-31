part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final Plant plant;

  AddToCart(this.plant);

  @override
  List<Object> get props => [plant];

  @override
  String toString() {
    return 'AddToCart { $plant }';
  }
}

class RemoveFromCart extends CartEvent {
  final Plant plant;

  RemoveFromCart(this.plant);

  @override
  List<Object> get props => [plant];

  @override
  String toString() {
    return 'RemoveFromCart { $plant }';
  }
}
