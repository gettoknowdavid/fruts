import 'package:fruts/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fruts/core/use_cases/no_params.dart';
import 'package:fruts/core/use_cases/use_case.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';
import 'package:fruts/features/crop/domain/repositories/crop_repository.dart';
import 'package:meta/meta.dart';

class GetAllCrops implements UseCase<List<Crop>, NoParams> {
  GetAllCrops({@required this.repository});

  final CropRepository repository;

  @override
  Future<Either<Failure, List<Crop>>> call(params) async {
    return await repository.getAllCrops();
  }
}
