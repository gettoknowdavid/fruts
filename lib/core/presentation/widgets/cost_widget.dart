import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CostWidget extends StatelessWidget {
  const CostWidget(
      {Key key,
      @required this.value,
      this.fontSize: 18,
      this.fontWeight: FontWeight.w400,
      this.color,
      this.mainAxisAlignment: MainAxisAlignment.start})
      : super(key: key);

  final double value;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final MainAxisAlignment mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final NumberFormat formatter = NumberFormat.simpleCurrency(
      decimalDigits: 2,
      locale: Localizations.localeOf(context).toString(),
    );

    final _value = formatter.format(value).split('\$')[1];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: mainAxisAlignment,
      children: <Widget>[
        Text(
          '\$',
          style: TextStyle(
            color: Colors.black45,
            fontSize: fontSize * 0.7,
          ),
        ),
        Text(
          _value,
          style: textTheme.headline6.copyWith(
            color: color ?? colorScheme.secondary.withOpacity(0.7),
            letterSpacing: 2.0,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}
