import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({
    Key key,
    this.addSidePadding = true,
    this.topChild,
    this.bottomChild,
    this.topChildHeight,
  }) : super(key: key);

  final bool addSidePadding;
  final Widget topChild;
  final Widget bottomChild;
  final double topChildHeight;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final appliedWidth = width * 0.96;
    final colorScheme = Theme.of(context).colorScheme;

    return Material(
      color: colorScheme.secondary,
      child: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(60),
              ),
              child: Container(
                height: topChildHeight ?? height * 0.93,
                width: addSidePadding ? appliedWidth : width,
                child: topChild,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                    child: bottomChild,
                    width: addSidePadding ? appliedWidth : width,
                  ) ??
                  Container(),
            ),
          ],
        ),
      ),
    );
  }
}
