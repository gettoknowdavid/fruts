import 'dart:async';

import 'package:fruts/screens/screens.dart';
import 'package:fruts/src/blocs/navigation/index.dart';
import 'package:fruts/src/models/screen_enum.dart';
import 'package:meta/meta.dart';

@immutable
abstract class NavigationEvent {
  Stream<NavigationState> applyAsync({
    NavigationState currentState,
    NavigationBloc bloc,
  });
}

class UpdateNavigationEvent extends NavigationEvent {
  final ScreenEnum screenEnum;

  UpdateNavigationEvent(this.screenEnum);
  @override
  Stream<NavigationState> applyAsync(
      {NavigationState currentState, NavigationBloc bloc}) async* {
    yield NavigationState(_screen(screenEnum));
  }

  Screen _screen(ScreenEnum screenEnum) {
    switch (screenEnum) {
      case ScreenEnum.cart:
        return cart;
        break;
      case ScreenEnum.home:
        return home;
        break;
      default:
        return account;
    }
  }
}
