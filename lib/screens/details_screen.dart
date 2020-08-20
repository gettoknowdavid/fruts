import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fruts/src/models/category.dart';
import 'package:fruts/src/models/nutrition_type.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:fruts/widgets/app_background.dart';
import 'package:fruts/widgets/custom_app_bar.dart';
import 'package:fruts/widgets/custom_back_button.dart';
import 'package:intl/intl.dart';

class _PlantCost extends StatelessWidget {
  const _PlantCost({
    Key key,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final NumberFormat formatter = NumberFormat.simpleCurrency(
      decimalDigits: 2,
      locale: Localizations.localeOf(context).toString(),
    );
    return Row(
      children: <Widget>[
        Text(
          formatter.format(plant.price),
          style: textTheme.headline4.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: colorScheme.secondaryVariant,
          ),
        ),
        Text(
          ' per kilo',
          style: textTheme.subtitle1.copyWith(
            fontWeight: FontWeight.w400,
            color: colorScheme.onSurface.withOpacity(0.5),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    );
  }
}

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key key, @required this.plant}) : super(key: key);

  final Plant plant;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    final topChildHeight = height * 0.74;
    final imageHeight = topChildHeight * 0.45;

    final category = enumFormatter(widget.plant.category);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: AppBackground(
        topChildHeight: topChildHeight,
        topChild: Scaffold(
          appBar: FrutsAppBar(
            title: '',
            leading: FrutsBackButton(),
          ),
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Container(
                  height: imageHeight,
                  width: width,
                  // color: Colors.pink,
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: Image.asset(widget.plant.image),
                  ),
                ),
                Spacer(),
                Text(
                  widget.plant.name,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: textTheme.headline3.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.7),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  widget.plant.genus,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: textTheme.headline5.copyWith(
                    color: colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
                Text(
                  category,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: textTheme.headline6.copyWith(
                    fontSize: 18,
                    color: Colors.black26,
                  ),
                ),
                SizedBox(height: 16),
                _PlantCost(plant: widget.plant),
              ],
            ),
          ),
        ),
        bottomChild: Container(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(height: 35),
              LimitedBox(
                maxHeight: height * 0.1,
                child: ListView.builder(
                  itemCount: widget.plant.nutritions.length,
                  scrollDirection: Axis.horizontal,
                  primary: false,
                  itemBuilder: (context, index) {
                    return NutritionWidget(
                      height: height,
                      plant: widget.plant,
                      nutrient: widget.plant.nutritions[index],
                    );
                  },
                ),
              ),
              SizedBox(height: 40),
              MaterialButton(
                elevation: 0.0,
                onPressed: () {},
                minWidth: width,
                height: 60,
                color: colorScheme.secondaryVariant,
                child: Text(
                  'Add to cart',
                  style: textTheme.button.copyWith(
                    fontSize: 20,
                    color: colorScheme.onSecondary,
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

    final width = MediaQuery.of(context).size.width;

    final type = nutrient.keys.elementAt(0);
    final value = nutrient.values.elementAt(0);

    final category = enumFormatter(type);

    return IntrinsicWidth(
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
