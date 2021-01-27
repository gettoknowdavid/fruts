import 'package:flutter/material.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';
import 'package:intl/intl.dart';

class CropCost extends StatelessWidget {
  const CropCost({
    Key key,
    @required this.crop,
  }) : super(key: key);

  final Crop crop;

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
          formatter.format(crop.price),
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
