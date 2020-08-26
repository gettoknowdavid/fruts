import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/src/blocs/cart/cart_bloc.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:fruts/widgets/custom_back_button.dart';
import 'package:fruts/widgets/fruts_app_bar.dart';

class CartScreen extends StatefulWidget {
  final bool showBackButton;

  const CartScreen({Key key, this.showBackButton = false}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Widget> children(List<Plant> plants, Map<int, int> plantsInCart) {
    return plantsInCart.keys.map((int id) {
      Plant plant = plants.firstWhere((p) => p.id == id);

      return CartItem(plant: plant, plantsInCart: plantsInCart);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final appBarHeight = FrutsAppBar().preferredSize.height - 20;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Container(
        height: height,
        width: width,
        child: Stack(
          children: <Widget>[
            Scaffold(
              backgroundColor: Theme.of(context).colorScheme.secondary,
              body: BlocBuilder<CartBloc, CartState>(
                cubit: context.bloc<CartBloc>(),
                builder: (context, state) {
                  if (state is CartLoaded) {
                    return ListView(
                      padding: EdgeInsets.only(top: appBarHeight + 20),
                      children: children(
                        state.plants,
                        state.plantsInCart,
                      ),
                    );
                  } else if (state is CartLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return Center(
                      child: Text('Cart Not Loaded'),
                    );
                  }
                },
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: appBarHeight,
                width: width * 0.96,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(60),
                  ),
                ),
                child: FrutsAppBar(
                  title: 'CART',
                  action: Icon(Icons.more_horiz),
                  leading:
                      !widget.showBackButton ? Container() : FrutsBackButton(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
    final cartItemHeight = height * 0.2;
    final cartItemWidth = width * 0.96;

    final sideMargin = (width - cartItemWidth) / 2;

    final imageWidth = cartItemWidth * 0.3;

    final actionWidth = cartItemWidth * 0.12;

    final itemQuantity = widget.plantsInCart[widget.plant.id];

    return Container(
      height: cartItemHeight,
      width: cartItemWidth,
      margin: EdgeInsets.symmetric(horizontal: sideMargin),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Container(
                width: imageWidth,
                color: Colors.pink,
                child: Image.asset(widget.plant.image),
              ),
              SizedBox(width: 12),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 26),
                child: Column(
                  children: <Widget>[
                    Text(
                      widget.plant.name,
                      style: textTheme.headline5,
                    ),
                    Text(
                      widget.plant.genus,
                      style: textTheme.headline5,
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                color: Colors.lightBlue,
                width: actionWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove_circle),
                      color: colorScheme.secondaryVariant,
                      onPressed: () => bloc.add(RemoveFromCart(widget.plant)),
                    ),
                    Text('$itemQuantity', style: textTheme.headline5),
                    IconButton(
                      icon: Icon(Icons.add_circle),
                      color: colorScheme.secondaryVariant,
                      onPressed: () => bloc.add(AddToCart(widget.plant)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
