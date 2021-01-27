import 'package:fruts/features/crop/domain/entities/crop.dart';

Map<int, int> mapCropIdsToQuantities(List<Crop> crops) {
  return Map.fromIterable(
    crops,
    key: (v) => v.id,
    value: (v) => crops.where((e) => e.id == v.id).toList().length,
  );
}
