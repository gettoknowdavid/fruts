import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enums/screen_enum.dart';
import '../blocs/navigation/navigation_bloc.dart';
import 'app_background.dart';
import 'fruts_bottom_navigation.dart';

class ScreenController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        cubit: navigationBloc,
        builder: (context, state) {
          final selectedIndex =
              ScreenEnum.values.indexOf(state.screen.screenEnum);
          return AppBackground(
            topChild: state.screen.child,
            bottomChild: FrutsBottomNavigationBar(
              size: size,
              selectedIndex: selectedIndex,
              items: _items(theme),
              onSelected: (index) {
                navigationBloc
                  ..add(UpdateNavigationEvent(ScreenEnum.values[index]));
              },
            ),
          );
        },
      ),
    );
  }

  Widget _icons(ScreenEnum screenEnum) {
    switch (screenEnum) {
      case ScreenEnum.cart:
        return Icon(Icons.shopping_bag);
        break;
      case ScreenEnum.home:
        return Icon(Icons.home);
        break;
      default:
        return Icon(Icons.person);
    }
  }

  List<FrutsBottomNavigationBarItem> _items(theme) {
    List<FrutsBottomNavigationBarItem> _items = [];

    for (ScreenEnum screenEnum in ScreenEnum.values) {
      _items.add(
        FrutsBottomNavigationBarItem(
          icon: _icons(screenEnum),
          activeColor: theme.colorScheme.onSecondary,
          inActiveColor: Colors.white24,
        ),
      );
    }

    return _items;
  }
}
