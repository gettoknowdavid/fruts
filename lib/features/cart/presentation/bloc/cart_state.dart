part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartEmpty extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  CartLoaded({@required this.crops, @required this.cropsToQuantity});

  final List<Crop> crops;
  final Map<int, int> cropsToQuantity;

  @override
  List<Object> get props => [crops, cropsToQuantity];
}

class CartError extends CartState {
  CartError({@required this.message});

  final String message;

  @override
  List<Object> get props => [message];
}
