import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/core/presentation/widgets/app_background.dart';
import 'package:fruts/core/presentation/widgets/custom_back_button.dart';
import 'package:fruts/core/presentation/widgets/fruts_app_bar.dart';
import 'package:fruts/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fruts/features/cart/presentation/widgets/cart_item.dart';
import 'package:fruts/features/cart/presentation/widgets/check_out_widget.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';

class CartPage extends StatefulWidget {
  final bool showBackButton;

  const CartPage({Key key, this.showBackButton = false}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Widget> children(List<Crop> crops, Map<int, int> cropsToQuantity) {
    return cropsToQuantity.keys.map((int id) {
      Crop crop = crops.firstWhere((p) => p.id == id);

      return CartItem(crop: crop, cropsToQuantity: cropsToQuantity);
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
            builder: (context, state) {
              if (state is CartLoaded) {
                return ListView(
                  padding: EdgeInsets.only(top: 20),
                  children: <Widget>[
                    Column(
                      children: children(
                        state.crops,
                        state.cropsToQuantity,
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
                return ListView(
                  padding: EdgeInsets.only(top: 20),
                  children: <Widget>[
                    Column(children: children([], {})),
                    CheckOutWidget(),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
