import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/src/blocs/cart/cart_bloc.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:fruts/widgets/app_background.dart';
import 'package:fruts/widgets/cart_item.dart';
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
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: AppBackground(
        topChild: Scaffold(
          appBar: FrutsAppBar(
            title: 'CART',
            action: Icon(Icons.more_horiz),
            leading: !widget.showBackButton ? Container() : FrutsBackButton(),
          ),
          body: BlocBuilder<CartBloc, CartState>(
            cubit: context.bloc<CartBloc>(),
            builder: (context, state) {
              if (state is CartLoaded) {
                return ListView(
                  padding: EdgeInsets.only(top: 20),
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
      ),
    );
  }
}
