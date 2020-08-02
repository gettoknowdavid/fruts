import 'package:flutter/material.dart';

class FrutsBackButton extends StatelessWidget {
  const FrutsBackButton({Key key, this.size, this.color}) : super(key: key);

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: ImageIcon(
        AssetImage('images/icons/arrows.png'),
        size: size ?? theme.iconTheme.size,
        color: color ?? theme.colorScheme.secondary,
      ),
    );
  }
}
