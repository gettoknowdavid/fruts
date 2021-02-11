import '../../domain/entities/cart.dart';
import '../../../crop/data/models/crop_model.dart';

abstract class CartLocalDataSource {
  Future<List<CropModel>> getAllCrops();
  
  Future<Cart> getAllCartCrops();

  Future<void> addToCart(int id);

  Future<void> removeFromCart(int id);
}
