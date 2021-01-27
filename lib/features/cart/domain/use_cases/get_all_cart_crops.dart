import 'package:fruts/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fruts/core/use_cases/no_params.dart';
import 'package:fruts/core/use_cases/use_case.dart';
import 'package:fruts/features/cart/domain/entities/cart.dart';
import 'package:fruts/features/cart/domain/repositories/cart_repository.dart';
import 'package:meta/meta.dart';

class GetAllCartCrops implements UseCase<Cart, NoParams> {
  GetAllCartCrops({@required this.repository});

  final CartRepository repository;

  @override
  Future<Either<Failure, Cart>> call(props) async {
    return await repository.getAllCartCrops();
  }
}
