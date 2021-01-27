part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class GetAllCartCropsEvent extends CartEvent {}

class AddToCartEvent extends CartEvent {
  final int id;

  AddToCartEvent({@required this.id});

  @override
  List<Object> get props => [id];
}

class RemoveFromCartEvent extends CartEvent {
  final int id;

  RemoveFromCartEvent({@required this.id});

  @override
  List<Object> get props => [id];
}

