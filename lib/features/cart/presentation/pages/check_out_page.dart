import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/custom_back_button.dart';
import '../../../../core/presentation/widgets/fruts_app_bar.dart';
import '../../../crop/domain/entities/crop.dart';
import '../widgets/check_out_details.dart';
import '../widgets/debit_card.dart';
import '../widgets/shipping_address.dart';

class CheckOutPage extends StatelessWidget {
  const CheckOutPage({
    Key key,
    @required this.crops,
    @required this.cropsToQuantity,
  }) : super(key: key);

  final List<Crop> crops;
  final Map<int, int> cropsToQuantity;

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    final deliveryCharge = 5.0;

    final _prices = crops.map((e) => e.price).toList();
    final _totalCropsCost = _prices.fold(0.0, (e, v) => e + v);
    final totalCost = _totalCropsCost + deliveryCharge;


    return Scaffold(
      appBar: FrutsAppBar(
        title: 'CHECK OUT',
        leading: FrutsBackButton(),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DebitCardWidget(),
            SizedBox(height: 70),
            ShippingAddress(),
            Divider(height: 60),
            SizedBox(height: 50),
            CheckOutDetails(
              totalCropsCost: _totalCropsCost,
              totalCost: totalCost,
            ),
            Spacer(),
            CheckOutButton(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

class CheckOutButton extends StatelessWidget {
  const CheckOutButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    onPressed() {}

    return Padding(
      padding: EdgeInsets.fromLTRB(36, 0, 36, 0),
      child: MaterialButton(
        elevation: 0.0,
        height: 60.0,
        color: colorScheme.secondaryVariant,
        onPressed: onPressed,
        minWidth: width,
        child: Text(
          'Check out',
          style: textTheme.button.copyWith(
            fontSize: 20,
            color: colorScheme.onSecondary,
          ),
        ),
      ),
    );
  }
}
