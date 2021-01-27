import 'package:fruts/core/utils/uuid.dart';
import 'package:fruts/features/crop/data/models/crop_model.dart';

import 'enums/category.dart';
import 'enums/nutrition_type.dart';

final tCropModel = CropModel(
  id: Uuid.v4(),
  name: 'Ackee',
  genus: 'Blighia',
  category: Category.exotics,
  nutritions: [
    {NutritionType.carbohydates: 11.0},
    {NutritionType.protein: 4.0},
    {NutritionType.fat: 9.0},
    {NutritionType.calories: 140.0},
    {NutritionType.sugar: 4.0},
  ],
  price: 1.99,
  imageUrl: 'images/exotics/ackee.png',
  rating: 4.7,
);
