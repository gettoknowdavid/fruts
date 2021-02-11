import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

import '../../../crop/data/models/crop_model.dart';
import '../../domain/entities/cart.dart';
import 'cart_local_data_source.dart';

class CartLocalDataSourceImplementation implements CartLocalDataSource {
  CartLocalDataSourceImplementation({
    @required this.database,
    @required this.store,
    @required this.cropStore,
  });

  final Database database;
  final StoreRef<int, Map<String, dynamic>> store;
  final StoreRef<int, Map<String, dynamic>> cropStore;

  @override
  Future<void> addToCart(int id) async {
    final crops = await getAllCrops();

    final crop = crops.firstWhere(((e) => e.id == id));

    await store.add(database, crop.toJson());
  }

  @override
  Future<Cart> getAllCartCrops() async {
    final finder = Finder(sortOrders: [SortOrder('id', true)]);
    final snapshot = await store.find(database, finder: finder);

    final crops = snapshot
        .map((e) => CropModel.fromJson(e.value))
        .toList(growable: false);

    final Map<int, int> cropsToQuantity = Map.fromIterable(
      crops,
      key: (v) => v.id,
      value: (v) => crops.where((e) => e.id == v.id).toList().length,
    );

    return Cart(crops: crops, cropsToQuantity: cropsToQuantity);
  }

  @override
  Future<List<CropModel>> getAllCrops() async {
    final snapshot = await cropStore.find(database);

    return snapshot
        .map((e) => CropModel.fromJson(e.value))
        .toList(growable: false);
  }

  @override
  Future<void> removeFromCart(int id) async {
    final finder = Finder(filter: Filter.equals('id', id));

    final _record = await store.findFirst(database, finder: finder);

    final key = _record.key;

    await store.record(key).delete(database);
  }
}
