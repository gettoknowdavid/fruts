import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/crop.dart';

abstract class CropRepository {
  Future<Either<Failure, List<Crop>>> getAllCrops();
}
