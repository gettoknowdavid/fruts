import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/src/blocs/cart/cart_bloc.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:fruts/widgets/add_remove_widget.dart';
import 'package:fruts/widgets/cost_widget.dart';

class CartItem extends StatefulWidget {
  final Plant plant;
  final Map<int, int> plantsInCart;

  const CartItem({Key key, this.plant, this.plantsInCart}) : super(key: key);

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  CartBloc get bloc => BlocProvider.of<CartBloc>(context);

  double get height => MediaQuery.of(context).size.height;
  double get width => MediaQuery.of(context).size.width;

  TextTheme get textTheme => Theme.of(context).textTheme;
  ColorScheme get colorScheme => Theme.of(context).colorScheme;

  int get itemQuantity => widget.plantsInCart[widget.plant.id];

  double get _subtotal => itemQuantity * widget.plant.price;

  @override
  Widget build(BuildContext context) {
    final cartItemHeight = height * 0.13;
    final cartItemWidth = width * 0.9;

    final sideMargin = (width - cartItemWidth) / 2;

    final imageWidth = cartItemWidth * 0.25;

    return Container(
      height: cartItemHeight,
      width: cartItemWidth,
      margin: EdgeInsets.all(sideMargin),
      child: Material(
        color: Colors.white,
        elevation: 20,
        shadowColor: colorScheme.secondary.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        child: Row(
          children: <Widget>[
            Container(
              width: imageWidth,
              child: Image.asset(widget.plant.image),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: AutoSizeText(
                            widget.plant.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.headline5.copyWith(
                              fontSize: 22,
                              color: colorScheme.secondary,
                            ),
                          ),
                        ),
                        SizedBox(width: 6),
                        CostWidget(value: _subtotal),
                      ],
                    ),
                    Text(
                      widget.plant.genus,
                      style: textTheme.subtitle2.copyWith(
                        color: Colors.black38,
                      ),
                    ),
                    AddRemoveWidget(
                      plantsInCart: widget.plantsInCart,
                      plant: widget.plant,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


