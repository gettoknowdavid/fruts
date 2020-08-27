import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/src/blocs/cart/cart_bloc.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:intl/intl.dart';

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
        child: Padding(
          padding: EdgeInsets.all(8.0),
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
                                color: colorScheme.secondary,
                              ),
                            ),
                          ),
                          SizedBox(width: 6),
                          _SubtotalCost(
                            plantsInCart: widget.plantsInCart,
                            plant: widget.plant,
                          ),
                        ],
                      ),
                      Text(
                        widget.plant.genus,
                        style: textTheme.subtitle2.copyWith(
                          color: Colors.black38,
                        ),
                      ),
                      SizedBox(height: 10),
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
      ),
    );
  }
}

class _SubtotalCost extends StatelessWidget {
  const _SubtotalCost({
    Key key,
    @required this.plantsInCart,
    @required this.plant,
  }) : super(key: key);

  final Plant plant;
  final Map<int, int> plantsInCart;

  int get itemQuantity => plantsInCart[plant.id];

  double get _subtotal => itemQuantity * plant.price;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final NumberFormat formatter = NumberFormat.simpleCurrency(
      decimalDigits: 2,
      locale: Localizations.localeOf(context).toString(),
    );

    final subtotal = formatter.format(_subtotal).split('\$')[1];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '\$',
          style: TextStyle(
            color: Colors.black45,
            fontSize: 16,
          ),
        ),
        Text(
          subtotal,
          style: textTheme.headline6.copyWith(
            color: colorScheme.secondary.withOpacity(0.7),
            letterSpacing: 2.0,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class AddRemoveWidget extends StatelessWidget {
  const AddRemoveWidget({
    Key key,
    @required this.plantsInCart,
    @required this.plant,
  }) : super(key: key);

  final Map<int, int> plantsInCart;
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final bloc = BlocProvider.of<CartBloc>(context);
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final itemQuantity = plantsInCart[plant.id];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        IconButton(
          icon: Icon(Icons.remove_circle),
          color: colorScheme.secondaryVariant,
          iconSize: 30,
          onPressed: () => bloc.add(RemoveFromCart(plant)),
        ),
        Text(
          '$itemQuantity',
          style: textTheme.headline5.copyWith(
            fontSize: 22,
            color: Colors.black54,
          ),
        ),
        IconButton(
          icon: Icon(Icons.add_circle),
          color: colorScheme.secondaryVariant,
          padding: EdgeInsets.zero,
          iconSize: 30,
          onPressed: () => bloc.add(AddToCart(plant)),
        ),
      ],
    );
  }
}
