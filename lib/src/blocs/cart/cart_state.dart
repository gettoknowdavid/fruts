part of 'cart_bloc.dart';

abstract class CartState extends Equatable {
  const CartState();
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<Plant> plants;
  final Map<int, int> plantsInCart;

  CartLoaded(
    this.plants, {
    this.plantsInCart = const {},
  });

  @override
  List<Object> get props => [plants, plantsInCart];
}

class CartNotLoaded extends CartState {}
