import 'package:flutter/material.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:intl/intl.dart';

class PlantCost extends StatelessWidget {
  const PlantCost({
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
