import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FrutsBottomNavigationBarItem {
  final Widget icon;
  final String title;
  final Color activeColor;
  final Color inActiveColor;

  const FrutsBottomNavigationBarItem({
    this.icon,
    this.title,
    this.activeColor,
    this.inActiveColor,
  });
}

class FrutsBottomNavigationBar extends StatelessWidget {
  final Size size;
  final selectedIndex;
  final List<FrutsBottomNavigationBarItem> items;
  final bool showTitle;
  final ValueChanged<int> onSelected;

  const FrutsBottomNavigationBar({
    Key key,
    @required this.size,
    @required this.selectedIndex,
    this.showTitle: false,
    @required this.items,
    @required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final containerHeight = size.height - (size.height * 0.93);
    final itemWidth = containerHeight * 2;

    return Container(
      height: containerHeight,
      width: size.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          var index = items.indexOf(item);
          bool isSelected = index == selectedIndex;
          Color color = !isSelected ? item.inActiveColor : item.activeColor;
          Color textColor = !isSelected
              ? item.inActiveColor.withOpacity(0.1)
              : item.activeColor.withOpacity(0.6);

          Text title = Text(
            item.title,
            textAlign: TextAlign.center,
            style: textTheme.headline6.copyWith(
              fontSize: 16,
              color: textColor,
            ),
          );

          return GestureDetector(
            onTap: () => onSelected(index),
            child: Semantics(
              container: true,
              selected: isSelected,
              child: Container(
                width: itemWidth,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconTheme(
                      data: IconTheme.of(context).copyWith(
                        color: color,
                        size: !showTitle ? 34 : 24,
                      ),
                      child: item.icon,
                    ),
                    !showTitle ? SizedBox() : SizedBox(height: 10),
                    !showTitle ? Container() : title
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
