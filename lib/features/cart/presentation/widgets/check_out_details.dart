import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/cost_widget.dart';

class CheckOutDetails extends StatelessWidget {
  const CheckOutDetails({Key key, this.totalCost, this.totalCropsCost})
      : super(key: key);
  final double totalCost;
  final double totalCropsCost;

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.fromLTRB(36, 0, 36, 0),
      child: Column(children: [
        _CheckDetailsRow(title: 'Order', value: totalCropsCost),
        SizedBox(height: 25),
        _CheckDetailsRow(title: 'Delivery', value: 5.0),
        SizedBox(height: 25),
        _CheckDetailsRow(
          title: 'Summary',
          value: totalCost,
          titleFontSize: 26,
          valueFontSize: 26,
        ),
      ]),
    );
  }
}

class _CheckDetailsRow extends StatelessWidget {
  const _CheckDetailsRow({
    Key key,
    this.title,
    this.value,
    this.titleFontSize,
    this.valueFontSize = 22,
  }) : super(key: key);

  final String title;
  final double value;
  final double titleFontSize;
  final double valueFontSize;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Text(
          title,
          style: textTheme.headline5.copyWith(
            fontSize: titleFontSize ?? 22,
            fontWeight: FontWeight.bold,
            color: textTheme.headline5.color.withOpacity(0.3),
          ),
        ),
        Spacer(),
        CostWidget(
          value: value,
          color: colorScheme.secondary,
          fontSize: valueFontSize ?? textTheme.headline4.fontSize,
          mainAxisAlignment: MainAxisAlignment.end,
        )
      ],
    );
  }
}
