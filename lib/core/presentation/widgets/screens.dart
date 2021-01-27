import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruts/core/constants/enums/screen_enum.dart';
import 'package:fruts/core/presentation/widgets/app_background.dart';
import 'package:fruts/core/presentation/widgets/fruts_app_bar.dart';
import 'package:fruts/features/cart/presentation/pages/cart_page.dart';
import 'package:fruts/features/crop/presentation/pages/crop_page.dart';

class Screen {
  final String title;
  final ScreenEnum screenEnum;
  final Widget child;

  Screen(this.title, this.screenEnum, this.child);
}

final Screen cart = Screen('CART', ScreenEnum.cart, CartPage());
final Screen home = Screen('HOME', ScreenEnum.home, CropsPage());
final Screen account = Screen('ACCOUNT', ScreenEnum.account, AccountPage());

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBackground(
      topChild: Scaffold(
        appBar: FrutsAppBar(),
        body: Container(
          child: Center(
            child: Text('data'),
          ),
        ),
      ),
    );
  }
}
