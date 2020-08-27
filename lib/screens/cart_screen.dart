import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/src/blocs/cart/cart_bloc.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:fruts/widgets/app_background.dart';
import 'package:fruts/widgets/cart_item.dart';
import 'package:fruts/widgets/cost_widget.dart';
import 'package:fruts/widgets/custom_back_button.dart';
import 'package:fruts/widgets/fruts_app_bar.dart';
import 'package:intl/intl.dart';

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
    //ignore:close_sinks
    final bloc = context.bloc<CartBloc>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final _totalPlantsCost = (bloc.state as CartLoaded)
        .plants
        .map((e) => e.price)
        .toList()
        .fold(0.0, (e, v) => e + v);
    final deliveryCharge = 5.0;
    final totalCost = _totalPlantsCost + deliveryCharge;

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: AppBackground(
        // topChildHeight: height * 0.85,
        topChild: Scaffold(
          appBar: FrutsAppBar(
            title: 'CART',
            action: Icon(Icons.more_horiz),
            leading: !widget.showBackButton ? Container() : FrutsBackButton(),
          ),
          body: BlocBuilder<CartBloc, CartState>(
            cubit: bloc,
            builder: (context, state) {
              if (state is CartLoaded) {
                return ListView(
                  padding: EdgeInsets.only(top: 20),
                  children: <Widget>[
                    Column(
                      children: children(
                        state.plants,
                        state.plantsInCart,
                      ),
                    ),
                    CheckOutWidget(),
                  ],
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
      ),
    );
  }
}

class CheckOutWidget extends StatelessWidget {
  const CheckOutWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //ignore:close_sinks
    final bloc = context.bloc<CartBloc>();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<CartBloc, CartState>(
      cubit: bloc,
      builder: (context, state) {
        final _totalPlantsCost = (state as CartLoaded)
            .plants
            .map((e) => e.price)
            .toList()
            .fold(0.0, (e, v) => e + v);

        final deliveryCharge = 5.0;

        final totalCost = _totalPlantsCost + deliveryCharge;

        return Container(
          height: height * 0.2,
          width: width,
          margin: EdgeInsets.only(top: 22, bottom: 40),
          padding: EdgeInsets.fromLTRB(26, 10, 26, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Delivery charge -',
                    style: textTheme.headline6.copyWith(
                      color: Colors.black45,
                    ),
                  ),
                  Spacer(),
                  CostWidget(
                    value: 5,
                    fontSize: textTheme.headline6.fontSize,
                    fontWeight: textTheme.headline6.fontWeight,
                    color: Colors.black45,
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ],
              ),
              Spacer(),
              Row(
                children: <Widget>[
                  Text(
                    'Total Cost -',
                    style: textTheme.headline6.copyWith(
                      color: Colors.black54,
                    ),
                  ),
                  Spacer(),
                  CostWidget(
                    value:
                        (state as CartLoaded).plants != null ? totalCost : 0.0,
                    color: colorScheme.secondary,
                    fontSize: textTheme.headline4.fontSize,
                    mainAxisAlignment: MainAxisAlignment.end,
                  ),
                ],
              ),
              Spacer(),
              MaterialButton(
                elevation: 0.0,
                height: 60.0,
                color: colorScheme.secondaryVariant,
                onPressed: () {},
                minWidth: width,
                child: Text(
                  'Check out',
                  style: textTheme.button.copyWith(
                    fontSize: 20,
                    color: colorScheme.onSecondary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
