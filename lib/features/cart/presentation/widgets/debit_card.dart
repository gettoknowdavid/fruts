import 'package:flutter/material.dart';
class DebitCardWidget extends StatelessWidget {
  const DebitCardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final cardHeight = height * 0.285;
    final cardWidth = width * 0.95;

    return Material(
      elevation: 12.0,
      shadowColor: colorScheme.secondary.withOpacity(0.2),
      borderRadius: BorderRadius.circular(20),
      color: Colors.white,
      child: Container(
        height: cardHeight,
        width: cardWidth,
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        child: Stack(
          children: [
            Positioned(
              bottom: cardHeight * 0.3,
              child: Container(
                child: Text(
                  '5399  8326  XXXX  XXXX',
                  style: textTheme.headline5.copyWith(
                    fontSize: 28,
                    letterSpacing: 3,
                    color: colorScheme.onBackground.withOpacity(0.7),
                  ),
                ),
              ),
            ),
            Positioned(
              left: cardWidth * 0.05,
              right: cardWidth * 0.05,
              bottom: cardHeight * 0.06,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'DAVID MICHAEL',
                      style: textTheme.headline6.copyWith(
                        letterSpacing: 3,
                        color: colorScheme.onBackground.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      '08/22',
                      style: textTheme.headline6.copyWith(
                        letterSpacing: 3,
                        color: colorScheme.onBackground.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Column(
                children: [
                  Image.asset('images/icons/mastercard.png'),
                  Text(
                    'mastercard.',
                    style: textTheme.headline6,
                  ),
                ],
              ),
            ),
            Positioned(
              top: 22,
              child: Column(
                children: [
                  Text(
                    'FIRST BANK, PLC',
                    style: textTheme.headline6.copyWith(
                      letterSpacing: 3,
                      color: colorScheme.onBackground.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
