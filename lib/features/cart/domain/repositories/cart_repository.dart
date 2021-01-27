import 'package:dartz/dartz.dart';
import 'package:fruts/core/errors/failures.dart';
import 'package:fruts/features/cart/domain/entities/cart.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';

abstract class CartRepository {
  Future<Either<Failure, Cart>> getAllCartCrops();

  Future<Either<Failure, Crop>> addToCart(int id);

  Future<Either<Failure, Crop>> removeFromCart(int id);
}
