import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/core/constants/enums/screen_enum.dart';
import 'package:fruts/core/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:fruts/core/presentation/widgets/cost_widget.dart';
import 'package:fruts/core/presentation/widgets/fade_page_route.dart';
import 'package:fruts/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fruts/features/cart/presentation/pages/check_out_page.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';

class CheckOutWidget extends StatelessWidget {
  const CheckOutWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoaded) {
          return CheckOutReady(
            crops: state.crops,
            cropsToQuantity: state.cropsToQuantity,
          );
        } else if (state is CartEmpty) {
          return Container(
            height: height * 0.2,
            width: width,
            margin: EdgeInsets.only(top: 22, bottom: 40),
            padding: EdgeInsets.fromLTRB(26, 10, 26, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  'Oops, looks like there\'s nothing in your basket. Want to add some fruts?',
                  textAlign: TextAlign.center,
                  style: textTheme.headline6.copyWith(
                    color: Colors.black45,
                  ),
                ),
                Spacer(),
                MaterialButton(
                  elevation: 0.0,
                  height: 60.0,
                  disabledColor: Colors.grey,
                  color: colorScheme.secondary,
                  onPressed: () => context.read<NavigationBloc>()
                    ..add(
                      UpdateNavigationEvent(ScreenEnum.home),
                    ),
                  minWidth: width,
                  child: Text(
                    'View Fruts',
                    style: textTheme.button.copyWith(
                      fontSize: 20,
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

class CheckOutReady extends StatelessWidget {
  const CheckOutReady({
    Key key,
    @required this.crops,
    @required this.cropsToQuantity,
  }) : super(key: key);

  final List<Crop> crops;
  final Map<int, int> cropsToQuantity;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;

    final deliveryCharge = 5.0;

    final _prices = crops.map((e) => e.price).toList();
    final _totalCropsCost = _prices.fold(0.0, (e, v) => e + v);
    final totalCost = _totalCropsCost + deliveryCharge;

    final isLoaded = crops.isNotEmpty;

    return Container(
      height: height * 0.2,
      width: width,
      margin: EdgeInsets.only(top: 22, bottom: 40),
      padding: EdgeInsets.fromLTRB(26, 10, 26, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          !isLoaded
              ? Text(
                  'Oops!\n Looks like your basket is empty. \nAdd some fruits and vegetables to it.',
                  textAlign: TextAlign.center,
                  style: textTheme.button.copyWith(
                    fontSize: 20,
                  ),
                )
              : Container(),
          _DeliveryCharge(isLoaded: isLoaded),
          Spacer(),
          _TotalCost(totalCost: totalCost, isLoaded: isLoaded),
          Spacer(),
          _CheckOutButton(
            crops: crops,
            cropsToQuantity: cropsToQuantity,
          ),
        ],
      ),
    );
  }
}

class _CheckOutButton extends StatelessWidget {
  const _CheckOutButton({
    Key key,
    @required this.crops,
    @required this.cropsToQuantity,
  }) : super(key: key);

  final List<Crop> crops;
  final Map<int, int> cropsToQuantity;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    final isLoaded = crops.isNotEmpty;

    onPressed() {
      isLoaded
          ? Navigator.push(
              context,
              FadePageRoute(
                  child: CheckOutPage(
                crops: crops,
                cropsToQuantity: cropsToQuantity,
              )),
            )
          : context.read<NavigationBloc>().add(
                UpdateNavigationEvent(ScreenEnum.home),
              );
    }

    return MaterialButton(
      elevation: 0.0,
      height: 60.0,
      color: isLoaded ? colorScheme.secondaryVariant : colorScheme.secondary,
      onPressed: onPressed,
      minWidth: width,
      child: Text(
        isLoaded ? 'Check out' : 'View fruts',
        style: textTheme.button.copyWith(
          fontSize: 20,
          color: colorScheme.onSecondary,
        ),
      ),
    );
  }
}

class _TotalCost extends StatelessWidget {
  const _TotalCost({
    Key key,
    @required this.totalCost,
    this.isLoaded = true,
  }) : super(key: key);

  final double totalCost;
  final bool isLoaded;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return isLoaded
        ? Row(
            children: <Widget>[
              Text(
                'Total Cost -',
                style: textTheme.headline6.copyWith(
                  color: Colors.black54,
                ),
              ),
              Spacer(),
              CostWidget(
                value: totalCost,
                color: colorScheme.secondary,
                fontSize: textTheme.headline4.fontSize,
                mainAxisAlignment: MainAxisAlignment.end,
              )
            ],
          )
        : Container();
  }
}

class _DeliveryCharge extends StatelessWidget {
  const _DeliveryCharge({
    Key key,
    this.isLoaded = true,
    this.deliveryCharge = 5.0,
  }) : super(key: key);
  final bool isLoaded;
  final double deliveryCharge;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return isLoaded
        ? Row(
            children: <Widget>[
              Text(
                'Delivery charge -',
                style: textTheme.headline6.copyWith(
                  color: Colors.black45,
                ),
              ),
              Spacer(),
              CostWidget(
                value: deliveryCharge,
                fontSize: textTheme.headline6.fontSize,
                fontWeight: textTheme.headline6.fontWeight,
                color: Colors.black45,
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ],
          )
        : Container();
  }
}
