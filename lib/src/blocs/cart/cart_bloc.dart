import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/src/core/plants_repository.dart';
import 'package:fruts/src/database/database_handler.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final PlantsRepository repository;
  CartBloc({@required this.repository}) : super(CartLoading());

  DatabaseHandler repo = DatabaseHandler();

  final cartQuantityController = BehaviorSubject<int>(sync: true);
  Stream<int> get cartQuantityStream => cartQuantityController.stream;

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is LoadCart) {
      try {
        yield* _mapLoadCartToState();
      } catch (_) {
        yield CartNotLoaded();
      }
    } else if (event is AddToCart) {
      yield* _mapAddToCartToState(event);
    } else if (event is RemoveFromCart) {
      yield* _mapRemoveFromCartToState(event);
    }
  }

  Stream<CartState> _mapLoadCartToState() async* {
    List<Plant> plants = await repository.loadCart();

    yield CartLoaded(plants);
  }

  Stream<CartState> _mapAddToCartToState(AddToCart event) async* {
    if (state is CartLoaded) {
      addToCart(event.plant);
      print(_plantsInCart);

      List<Plant> plants = List<Plant>.from((state as CartLoaded).plants)
        ..add(event.plant);
      availaiblePlants.addAll(plants);

      Map<int, int> thePlantsInCart = Map<int, int>.from(_plantsInCart);

      yield CartLoaded(plants, plantsInCart: thePlantsInCart);

      await repository.insertCart(event.plant);
    }
  }

  Stream<CartState> _mapRemoveFromCartToState(RemoveFromCart event) async* {
    if (state is CartLoaded) {
      removeFromCart(event.plant);
      print(_plantsInCart);

      List<Plant> plants = List<Plant>.from((state as CartLoaded).plants)
        ..remove(event.plant);

      Map<int, int> thePlantsInCart = Map<int, int>.from(_plantsInCart);

      yield CartLoaded(plants, plantsInCart: thePlantsInCart);

      await repository.insertCart(event.plant);
    }
  }

  Map<int, int> _plantsInCart = <int, int>{};

  Map<int, int> get plantsInCart => Map<int, int>.from(_plantsInCart);

  List<Plant> availaiblePlants = [];

  void addToCart(Plant plant, [int quantity = 1]) {
    var count = _plantsInCart[plant.id];

    if (count != null) {
      count += quantity;
    } else {
      count = quantity;
    }

    _plantsInCart[plant.id] = count;
    cartQuantityController.add(totalCartQuantity);
  }

  void removeFromCart(Plant plant) {
    var count = _plantsInCart[plant.id];

    if (count != null) {
      if (count == 1) {
        _plantsInCart.remove(plant.id);
      } else {
        count--;
        _plantsInCart[plant.id] = count;
      }
    }

    cartQuantityController.add(totalCartQuantity);
  }

  int get totalCartQuantity {
    return _plantsInCart.values.fold(0, (v, e) => v + e);
  }

  @override
  Future<void> close() {
    cartQuantityController.close();
    return super.close();
  }
}
