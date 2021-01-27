import 'package:dartz/dartz.dart';
import 'package:fruts/core/errors/failures.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';

abstract class CropRepository {
  Future<Either<Failure, List<Crop>>> getAllCrops();
}
