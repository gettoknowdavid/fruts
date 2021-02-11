import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../features/account/presentation/pages/account_screen.dart';
import '../../../features/cart/presentation/pages/cart_page.dart';
import '../../../features/crop/presentation/pages/crop_page.dart';
import '../../constants/enums/screen_enum.dart';

class Screen {
  final String title;
  final ScreenEnum screenEnum;
  final Widget child;

  Screen(this.title, this.screenEnum, this.child);
}

final Screen cart = Screen('CART', ScreenEnum.cart, CartPage());
final Screen home = Screen('HOME', ScreenEnum.home, CropsPage());
final Screen account = Screen('ACCOUNT', ScreenEnum.account, AccountPage());

