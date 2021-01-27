import 'package:fruts/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fruts/core/use_cases/params.dart';
import 'package:fruts/core/use_cases/use_case.dart';
import 'package:fruts/features/cart/domain/repositories/cart_repository.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';
import 'package:meta/meta.dart';

class AddToCart implements UseCase<Crop, Params> {
  AddToCart({@required this.repository});

  final CartRepository repository;

  @override
  Future<Either<Failure, Crop>> call(Params params) async {
    return await repository.addToCart(params.id);
  }
}
