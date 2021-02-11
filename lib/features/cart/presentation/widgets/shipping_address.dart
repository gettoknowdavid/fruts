import 'package:flutter/material.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.fromLTRB(36, 0, 36, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Shipping Address',
            style: textTheme.headline5.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: colorScheme.onBackground.withOpacity(0.7),
            ),
          ),
          SizedBox(height: 10),
          Text(
            '#1 Stadium Road\nRumuomasi, Port Harcourt\nRivers, Nigeria',
            style: textTheme.headline6.copyWith(
              fontWeight: FontWeight.normal,
              letterSpacing: 0.3,
              color: colorScheme.onBackground.withOpacity(0.4),
            ),
          ),
        ],
      ),
    );
  }
}
