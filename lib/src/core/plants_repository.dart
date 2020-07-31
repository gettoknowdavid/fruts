import 'package:fruts/src/models/plant.dart';

abstract class PlantsRepository {
  Future<List<Plant>> loadPlants();

  Future<List<Plant>> loadCart();

  Future insertCart(Plant plant);

  Future insertPlants(List<Plant> plants);
}
