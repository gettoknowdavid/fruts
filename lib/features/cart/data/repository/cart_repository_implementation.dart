import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';

import '../../../../core/errors/failures.dart';
import '../../../crop/domain/entities/crop.dart';
import '../../domain/entities/cart.dart';
import '../../domain/repositories/cart_repository.dart';
import '../data_sources/cart_local_data_source.dart';

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
