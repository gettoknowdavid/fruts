import 'package:fruts/core/data/crops.dart';
import 'package:fruts/features/crop/data/data_sources/crop_local_data_source.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';
import 'package:fruts/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fruts/features/crop/domain/repositories/crop_repository.dart';
import 'package:meta/meta.dart';

class CropRepositoryImplementation implements CropRepository {
  CropRepositoryImplementation({@required this.source});

  final CropLocalDataSource source;

  @override
  Future<Either<Failure, List<Crop>>> getAllCrops() async {
    // Stores the list of crops from [allCrops] into the Sembast
    // database
    await source.storeAllCrops(allCropModels);

    final allCrops = await source.getAllCrops();

    // Retrieves the list of all the crops from the
    // Sembast database
    // final crops = await source.getAllCrops();
    // Returns the [List<Crop>] using [Right]
    return Right(allCrops);
  }
}
