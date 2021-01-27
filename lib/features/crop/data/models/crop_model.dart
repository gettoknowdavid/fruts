import 'package:fruts/core/constants/enums/category.dart';
import 'package:fruts/core/constants/enums/nutrition_type.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';
import 'package:json_annotation/json_annotation.dart';

part 'crop_model.g.dart';

@JsonSerializable(explicitToJson: true)
class CropModel extends Crop {
  CropModel({
    int id,
    String name,
    String genus,
    Category category,
    List<Map<NutritionType, double>> nutritions,
    double price,
    String imageUrl,
    double rating,
  }) : super(
          id: id,
          name: name,
          genus: genus,
          category: category,
          nutritions: nutritions,
          price: price,
          imageUrl: imageUrl,
          rating: rating,
        );

  CropModel copyWith({
    int id,
  }) {
    return CropModel(
      id: id ?? this.id,
      name: name,
      genus: genus,
      category: category,
      nutritions: nutritions,
      price: price,
      imageUrl: imageUrl,
      rating: rating,
    );
  }

  static CropModel fromJson(Map<String, dynamic> json) =>
      _$CropModelFromJson(json);
  Map<String, dynamic> toJson() => _$CropModelToJson(this);
}
