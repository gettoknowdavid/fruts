import 'package:flutter/material.dart';

class PaddedColumn extends StatelessWidget {
  const PaddedColumn({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {

        return ListView(
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          children: <Widget>[
            // SizedBox(height: spacerHeight),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: child,
            ),
          ],
        );
      },
    );
  }
}

class NormalColumn extends StatelessWidget {
  const NormalColumn({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ListView(
      // physics: const ClampingScrollPhysics(),
      // reverse: true,
      shrinkWrap: true,

      children: <Widget>[
        const SizedBox(height: 120.0),
        child,
      ],
    );
  }
}
