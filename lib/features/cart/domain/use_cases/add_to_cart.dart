import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/use_cases/params.dart';
import '../../../../core/use_cases/use_case.dart';
import '../repositories/cart_repository.dart';
import '../../../crop/domain/entities/crop.dart';
import 'package:meta/meta.dart';

class AddToCart implements UseCase<Crop, Params> {
  AddToCart({@required this.repository});

  final CartRepository repository;

  @override
  Future<Either<Failure, Crop>> call(Params params) async {
    return await repository.addToCart(params.id);
  }
}
