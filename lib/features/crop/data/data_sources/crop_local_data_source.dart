import '../models/crop_model.dart';

abstract class CropLocalDataSource {
  Future<List<CropModel>> getAllCrops();

  Future<void> storeAllCrops(List<CropModel> crops);
}