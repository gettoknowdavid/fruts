import 'package:fruts/src/core/plants_repository.dart';
import 'package:fruts/src/database/fruts_database.dart';
import 'package:fruts/src/models/cart.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:sembast/sembast.dart';

class DatabaseHandler extends PlantsRepository {
  static const String PLANT_STORE_NAME = 'plant__';
  static const String CART_STORE_NAME = 'cart__';
  final _plantStore = intMapStoreFactory.store(PLANT_STORE_NAME);
  final _cartStore = intMapStoreFactory.store(CART_STORE_NAME);

  Future<Database> get _database async => await FrutsDatabase.instance.database;

  @override
  Future insertCart(Plant plant) async {
    await _cartStore.add(await _database, plant.toJson());
  }

  @override
  Future insertPlants(List<Plant> plants) async {
    await _plantStore.addAll(
      await _database,
      plants.map((e) => e.toJson()).toList(),
    );
  }

  @override
  Future<List<Plant>> loadCart() async {
    final snapshots = await _cartStore.find(await _database);

    return snapshots
        .map((s) => Plant.fromJson(s.value))
        .toList(growable: false);
  }

  Future<Cart> getPlantCart() async {
    final snap = await _cartStore.find(await _database);

    final carts = snap.map((e) => Cart.fromJson(e.value)).toList();

    return carts.elementAt(0);
  }

  Future insertPlantIntoCart(Cart cart) async {
    await _cartStore.add(await _database, cart.toJson());
  }

  @override
  Future<List<Plant>> loadPlants() async {
    final snapshots = await _plantStore.find(await _database);

    return snapshots
        .map((s) => Plant.fromJson(s.value))
        .toList(growable: false);
  }
}
