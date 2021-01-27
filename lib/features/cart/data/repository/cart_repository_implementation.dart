import 'package:fruts/features/cart/data/data_sources/cart_local_data_source.dart';
import 'package:fruts/features/cart/domain/entities/cart.dart';
import 'package:fruts/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:fruts/features/cart/domain/repositories/cart_repository.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';
import 'package:meta/meta.dart';

class CartRepositoryImplementation implements CartRepository {
  CartRepositoryImplementation({@required this.source});

  final CartLocalDataSource source;

  @override
  Future<Either<Failure, Crop>> addToCart(int id) async {
    await source.addToCart(id);

    final crops = await source.getAllCrops();

    final crop = crops.firstWhere((e) => e.id == id);

    return Right(crop);
  }

  @override
  Future<Either<Failure, Cart>> getAllCartCrops() async {
    final result = await source.getAllCartCrops();

    return Right(result); 
  }

  @override
  Future<Either<Failure, Crop>> removeFromCart(int id) async {
    await source.removeFromCart(id);

    final crops = await source.getAllCrops();

    final crop = crops.where((e) => e.id == id).last;

    return Right(crop);
  }
}
