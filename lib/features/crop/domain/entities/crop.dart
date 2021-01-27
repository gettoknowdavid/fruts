import 'package:equatable/equatable.dart';
import 'package:fruts/core/constants/enums/category.dart';
import 'package:fruts/core/constants/enums/nutrition_type.dart';
import 'package:fruts/core/utils/uuid.dart';


class Crop extends Equatable {
  final int id;
  final String name;
  final String genus;
  final Category category;
  final List<Map<NutritionType, double>> nutritions;
  final double price;
  final String imageUrl;
  final double rating;

  Crop({
    int id,
    this.name,
    this.genus,
    this.category,
    this.nutritions,
    this.price,
    this.imageUrl,
    this.rating,
  }) : id = id ?? Uuid.v4();

  @override
  List<Object> get props => [
        id,
        name,
        genus,
        category,
        nutritions,
        price,
        imageUrl,
        rating,
      ];


  // @override
  // String toString() {
  //   return 'Crop { id: $id, name: $name, genus: $genus, category: $category, nutritions: $nutritions: price: $price, image: $imageUrl, rating: $rating }';
  // }
}
