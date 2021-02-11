import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../crop/domain/entities/crop.dart';
import '../entities/cart.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> getAllCartCrops();

  Future<Either<Failure, Crop>> addToCart(int id);

  Future<Either<Failure, Crop>> removeFromCart(int id);
}
