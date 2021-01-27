import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';

class AddToCartButton extends StatefulWidget {
  const AddToCartButton({
    Key key,
    @required this.crop,
    @required this.cartQuantity,
  }) : super(key: key);

  final Crop crop;
  final int cartQuantity;

  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton>
    with SingleTickerProviderStateMixin {
  CartBloc get cartBloc => BlocProvider.of<CartBloc>(context);
  AnimationController animationController;
  Animation<double> bottomBoxAnimation;
  Animation<double> buttonOpacity;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..addListener(() {
        setState(() {});
      });
    bottomBoxAnimation = Tween<double>(begin: 120, end: 0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    buttonOpacity = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.fastOutSlowIn,
      ),
    );
    final cropsToQuantity = (cartBloc.state as CartLoaded).cropsToQuantity;
    int itemQuantity = cropsToQuantity[widget.crop.id];

    if (itemQuantity != null) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AddToCartButton oldWidget) {
    super.didUpdateWidget(oldWidget);

    final cropsToQuantity = (cartBloc.state as CartLoaded).cropsToQuantity;
    int itemQuantity = cropsToQuantity[widget.crop.id];

    if (itemQuantity != null) {
      animationController.forward();
    } else {
      animationController.reverse();
    }

    if (itemQuantity != null) {
      animationController.forward();
    } else {
      animationController.reverse();
    }
  }

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final height = size.height;
    final width = size.width;

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    final cropsToQuantity = (cartBloc.state as CartLoaded).cropsToQuantity;
    final itemQuantity = cropsToQuantity[widget.crop.id];

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        AnimatedContainer(
          duration: Duration(milliseconds: 600),
          alignment: Alignment.center,
          // width:  width,
          width: itemQuantity != null ? 0.0 : width,
          child: MaterialButton(
            elevation: 0.0,
            height: 60.0,
            color: colorScheme.secondaryVariant,
            onPressed: () {
              cartBloc.add(AddToCartEvent(id: widget.crop.id));
              animationController.forward();
            },
            minWidth: width,
            child: Transform.scale(
              scale: buttonOpacity.value,
              child: Text(
                'Add to cart',
                style: textTheme.button.copyWith(
                  fontSize: 20,
                  color: colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0, bottomBoxAnimation.value),
          child: Material(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(60),
            ),
            color: colorScheme.secondaryVariant,
            child: Container(
              height: 100.0,
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    color: colorScheme.onSecondary,
                    onPressed: () {
                      cartBloc.add(RemoveFromCartEvent(id: widget.crop.id));
                    },
                  ),
                  Material(
                    color: colorScheme.onSecondary,
                    type: MaterialType.circle,
                    elevation: 12,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        itemQuantity == null ? '0' : '$itemQuantity',
                        style: textTheme.headline5,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    color: colorScheme.onSecondary,
                    onPressed: () {
                      cartBloc.add(AddToCartEvent(id: widget.crop.id));
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
