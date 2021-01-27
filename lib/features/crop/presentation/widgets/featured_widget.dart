import 'package:flutter/material.dart';

class FeaturedWidget extends StatelessWidget {
  const FeaturedWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 26.0, bottom: 16.0),
          child: Text(
            'Featured',
            style: textTheme.headline5.copyWith(fontSize: 26.0),
          ),
        ),
        Container(
          height: height * 0.25,
          width: width,
          margin: EdgeInsets.symmetric(horizontal: 26),
          child: Material(
            elevation: 26,
            color: colorScheme.primary,
            borderRadius: BorderRadius.circular(30),
            shadowColor: colorScheme.secondary.withOpacity(0.16),
            child: Image.asset('images/exotics/rambutan.png'),
          ),
        ),
      ],
    );
  }
}
