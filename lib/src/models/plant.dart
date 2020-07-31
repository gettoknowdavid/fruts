import 'package:equatable/equatable.dart';
import 'package:fruts/src/data/uuid.dart';
import 'package:fruts/src/models/category.dart';
import 'package:fruts/src/models/nutrition_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'plant.g.dart';

@JsonSerializable()
class Plant extends Equatable {
  final int id;
  final String name;
  final String genus;
  final Category category;
  final List<Map<NutritionType, double>> nutritions;
  final double price;
  final String image;
  final double rating;

  Plant({
    int id,
    this.name,
    this.genus,
    this.category = Category.all,
    this.nutritions,
    this.price,
    this.image,
    this.rating,
  }) : id = id ?? Uuid.v4();

  @override
  List<Object> get props => [id, name, genus, category, nutritions, price, image, rating];

  static Plant fromJson(Map<String, dynamic> json) => _$PlantFromJson(json);
  Map<String, dynamic> toJson() => _$PlantToJson(this);

  @override
  String toString() {
    return 'Plant { id: $id, name: $name, genus: $genus, category: $category, nutritions: $nutritions: price: $price, image: $image, rating: $rating }';
  }
}