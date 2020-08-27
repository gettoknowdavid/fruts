import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruts/src/blocs/cart/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/widgets/cart_bag.dart';

class FrutsBottomNavigationBarItem {
  final Widget icon;
  final Color activeColor;
  final Color inActiveColor;

  const FrutsBottomNavigationBarItem({
    this.icon,
    this.activeColor,
    this.inActiveColor,
  });
}

class FrutsBottomNavigationBar extends StatelessWidget {
  final Size size;
  final selectedIndex;
  final List<FrutsBottomNavigationBarItem> items;
  final ValueChanged<int> onSelected;

  const FrutsBottomNavigationBar({
    Key key,
    @required this.size,
    @required this.selectedIndex,
    @required this.items,
    @required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final containerHeight = size.height - (size.height * 0.93);
    final itemWidth = containerHeight * 2;

    return Container(
      height: containerHeight,
      width: size.width,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          int index = items.indexOf(item);
          bool isSelected = index == selectedIndex;
          Color color = !isSelected ? item.inActiveColor : item.activeColor;

          return GestureDetector(
            onTap: () => onSelected(index),
            child: Semantics(
              container: true,
              selected: isSelected,
              child: Container(
                width: itemWidth,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: index != 0
                    ? Container(
                        child: IconTheme(
                          data: IconThemeData(color: color, size: 34),
                          child: item.icon,
                        ),
                      )
                    : StreamBuilder<int>(
                        stream: context.bloc<CartBloc>().cartQuantityStream,
                        builder: (context, snapshot) {
                          return CartBag(value: snapshot.data, color: color);
                        },
                      ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
