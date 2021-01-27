part of 'navigation_bloc.dart';

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
      case ScreenEnum.account:
        return account;
      default:
        return home;
    }
  }
}
