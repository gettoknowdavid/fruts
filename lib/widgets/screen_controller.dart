import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/screens/screens.dart';
import 'package:fruts/src/blocs/navigation/index.dart';
import 'package:fruts/src/models/screen_enum.dart';
import 'package:fruts/widgets/app_background.dart';
import 'package:fruts/widgets/fruts_bottom_navigation.dart';

class ScreenController extends StatefulWidget {
  @override
  _ScreenControllerState createState() => _ScreenControllerState();
}

class _ScreenControllerState extends State<ScreenController> {
  NavigationBloc get navigationBloc => BlocProvider.of<NavigationBloc>(context);
  Size get size => MediaQuery.of(context).size;
  ThemeData get theme => Theme.of(context);

  Widget _icons(ScreenEnum screenEnum) {
    switch (screenEnum) {
      case ScreenEnum.cart:
        return Icon(Icons.shopping_basket);
        break;
      case ScreenEnum.home:
        return Icon(Icons.home);
        break;
      default:
        return Icon(Icons.person);
    }
  }

  List<FrutsBottomNavigationBarItem> get _items {
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

  @override
  Widget build(BuildContext context) {
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
              items: _items,
              onSelected: (index) {
                return navigationBloc
                  ..add(UpdateNavigationEvent(ScreenEnum.values[index]));
              },
            ),
          );
        },
      ),
    );
  }
}
