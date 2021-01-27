import 'package:fruts/features/crop/data/data_sources/crop_local_data_source.dart';
import 'package:fruts/features/crop/data/models/crop_model.dart';
import 'package:meta/meta.dart';
import 'package:sembast/sembast.dart';

class CropLocalDataSourceImplementation implements CropLocalDataSource {
  CropLocalDataSourceImplementation({
    @required this.database,
    @required this.store,
  });

  Database database;
  StoreRef<int, Map<String, dynamic>> store;

  @override
  Future<List<CropModel>> getAllCrops() async {
    final finder = Finder(sortOrders: [SortOrder('key', false)]);

    final snapshots = await store.find(database, finder: finder);

    return snapshots.map((e) => CropModel.fromJson(e.value)).toList();
    
  }

  @override
  Future<void> storeAllCrops(List<CropModel> crops) async {
    await store.drop(database);
    
    int key = 0;

    return await store.addAll(
      database,
      crops.map((e) => e.copyWith(id: key++).toJson()).toList(),
    );
  }
}
