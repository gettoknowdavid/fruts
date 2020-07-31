import 'package:flutter/material.dart';
import 'package:fruts/screens/cart_screen.dart';
import 'package:fruts/src/blocs/cart/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartBag extends StatefulWidget {
  const CartBag({Key key}) : super(key: key);

  @override
  _CartBagState createState() => _CartBagState();
}

class _CartBagState extends State<CartBag> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final outerSize = 46.0;
    final smallSize = 24.5;
    final left = (outerSize - smallSize) + (smallSize / 5);


    return StreamBuilder<int>(
      stream: context.bloc<CartBloc>().cartQuantityStream,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartScreen()),
            );
          },
          child: Stack(
            alignment: Alignment.center,
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                height: outerSize,
                width: outerSize,
                padding: EdgeInsets.all(8),
                child: ImageIcon(
                  AssetImage('images/icons/cart-bag.png'),
                ),
              ),
              !snapshot.hasData
                  ? Container()
                  : Positioned(
                      left: left,
                      bottom: left,
                      child: Container(
                        height: smallSize,
                        width: smallSize,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: colorScheme.secondaryVariant,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${snapshot.data}',
                          style: textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w600,
                            color: colorScheme.primary,
                          ),
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
