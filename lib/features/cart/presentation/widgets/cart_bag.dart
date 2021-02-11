import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CartBag extends StatefulWidget {
  const CartBag({Key key, @required this.value, this.color}) : super(key: key);

  final int value;
  final Color color;

  @override
  _CartBagState createState() => _CartBagState();
}

class _CartBagState extends State<CartBag> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> bounceAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 20),
    );

    bounceAnimation = Tween<double>(begin: 0.75, end: 2.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.elasticInOut),
    )..addListener(() => setState(() {}));

    controller.forward().whenComplete(() => controller.reverse());
  }

  animate() {
    controller
        .forward()
        .whenComplete(() => controller.reverse())
        .whenComplete(() => controller.reset());
  }

  @override
  void didUpdateWidget(CartBag oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) animate();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final outerSize = 46.0;
    final smallSize = 30.0;
    final left = (outerSize - smallSize) + (smallSize / 3);

    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: <Widget>[
        Container(
          // height: outerSize,
          // width: outerSize,
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.shopping_bag,
            size: 34,
            color: widget.color ?? colorScheme.secondary,
          ),
        ),
        if (widget.value == 0 || widget.value == null)
          Container()
        else
          Positioned(
            left: left,
            bottom: left,
            child: ScaleTransition(
              scale: bounceAnimation,
              child: Container(
                height: smallSize,
                width: smallSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colorScheme.secondaryVariant,
                  shape: BoxShape.circle,
                ),
                child: AutoSizeText(
                  '${widget.value}',
                  style: textTheme.headline6.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
