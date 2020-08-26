import 'package:flutter/cupertino.dart';
import 'package:fruts/screens/account_screen.dart';
import 'package:fruts/screens/cart_screen.dart';
import 'package:fruts/screens/home_screen.dart';
import 'package:fruts/src/models/screen_enum.dart';

class Screen {
  final String title;
  final ScreenEnum screenEnum;
  final Widget child;

  Screen(this.title, this.screenEnum, this.child);
}

final Screen cart = Screen('CART', ScreenEnum.cart, CartScreen());
final Screen home = Screen('HOME', ScreenEnum.home, HomeScreen());
final Screen account = Screen('ACCOUNT', ScreenEnum.account, AccountScreen());
