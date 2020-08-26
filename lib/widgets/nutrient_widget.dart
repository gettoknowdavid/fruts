import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fruts/screens/test_screen.dart';
import 'package:fruts/src/models/category.dart';
import 'package:fruts/src/models/nutrition_type.dart';
import 'package:fruts/src/models/plant.dart';

class NutritionWidget extends StatelessWidget {
  const NutritionWidget({
    Key key,
    @required this.plant,
    @required this.nutrient,
    @required this.height,
    this.color,
  }) : super(key: key);

  final Plant plant;
  final Map<NutritionType, double> nutrient;
  final double height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    // final width = MediaQuery.of(context).size.width;

    final type = nutrient.keys.elementAt(0);
    final value = nutrient.values.elementAt(0);

    final category = enumFormatter(type);

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TestScreen(),
        ),
      ),
      child: IntrinsicWidth(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          margin: EdgeInsets.only(right: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: <Widget>[
              Text(
                category,
                style: textTheme.headline5.copyWith(
                  color: Colors.black87,
                ),
              ),
              SizedBox(width: 10),
              Container(
                height: (height * 0.1) * 0.85,
                width: (height * 0.1) * 0.85,
                child: CustomPaint(
                  size: MediaQuery.of(context).size,
                  painter: ValuePainter(
                    valuePercent(type, value),
                    color: colorScheme.secondaryVariant,
                  ),
                  child: Center(
                    child: AutoSizeText(
                      '${value.toInt()}',
                      style: textTheme.headline5.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ValuePainter extends CustomPainter {
  final double value;
  final Color color;

  ValuePainter(this.value, {this.color});

  @override
  void paint(Canvas canvas, Size size) {
    var progressPaint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.butt;

    Offset center = Offset(size.width / 2, size.height / 2);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: (size.width / 2.2) - 8),
      -pi / 2,
      2 * pi * (value / 100),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

double valuePercent(NutritionType type, double value) {
  double standardRate;

  switch (type) {
    case NutritionType.fat:
      standardRate = 44.0;
      double result = (value / standardRate) * 100;
      return result.roundToDouble();
      break;
    case NutritionType.carbohydates:
      standardRate = 250.0;
      double result = (value / standardRate) * 100;
      return result.roundToDouble();
      break;
    case NutritionType.protein:
      standardRate = 56.0;
      double result = (value / standardRate) * 100;
      return result.roundToDouble();
      break;
    case NutritionType.sugar:
      standardRate = 30.5;
      double result = (value / standardRate) * 100;
      return result.roundToDouble();
      break;
    default:
      standardRate = 2500.0;
      double result = (value / standardRate) * 100;
      return result.roundToDouble();
  }
}
