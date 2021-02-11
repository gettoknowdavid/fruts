import '../../../../core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/use_cases/no_params.dart';
import '../../../../core/use_cases/use_case.dart';
import '../entities/cart.dart';
import '../repositories/cart_repository.dart';
import 'package:meta/meta.dart';

class GetAllCartCrops implements UseCase<Cart, NoParams> {
  GetAllCartCrops({@required this.repository});

  final CartRepository repository;

  @override
  Future<Either<Failure, Cart>> call(props) async {
    return await repository.getAllCartCrops();
  }
}
