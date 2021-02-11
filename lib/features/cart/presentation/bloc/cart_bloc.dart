import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/use_cases/no_params.dart';
import '../../../../core/use_cases/params.dart';
import '../../domain/entities/cart.dart';
import '../../domain/use_cases/add_to_cart.dart';
import '../../domain/use_cases/get_all_cart_crops.dart';
import '../../domain/use_cases/remove_from_cart.dart';
import '../../../crop/domain/entities/crop.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc({
    @required this.getAllCartCrops,
    @required this.addToCart,
    @required this.removeFromCart,
  }) : super(CartEmpty());

  GetAllCartCrops getAllCartCrops;
  AddToCart addToCart;
  RemoveFromCart removeFromCart;


  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is GetAllCartCropsEvent) {
      final cartCrops = await getAllCartCrops(NoParams());
      yield CartLoading();

      yield* _eitherFailureOrCarts(cartCrops);
    } else if (event is AddToCartEvent) {
      await addToCart(Params(id: event.id));

      final result = await getAllCartCrops(NoParams());

      yield CartLoading();
      yield* _eitherFailureOrCarts(result);
    } else if (event is RemoveFromCartEvent) {
      await removeFromCart(Params(id: event.id));

      final result = await getAllCartCrops(NoParams());

      yield CartLoading();

      yield* _eitherFailureOrCarts(result);
    }
  }

  Stream<CartState> _eitherFailureOrCarts(
      Either<Failure, Cart> failureOrCart) async* {
    yield failureOrCart.fold(
      (failure) => CartError(message: _mapFailureToMessage(failure)),
      (cart) =>
          CartLoaded(crops: cart.crops, cropsToQuantity: cart.cropsToQuantity),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DatabaseFailure:
        return 'Database Error: Failed to load last air quality from store.';
      default:
        return 'Unexpected Error';
    }
  }
}
