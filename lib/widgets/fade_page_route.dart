import 'package:flutter/material.dart';

class FadePageRoute extends PageRouteBuilder {
  final Widget child;

  FadePageRoute({@required this.child})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, widget) {
            return FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0).animate(
                CurvedAnimation(parent: animation, curve: Curves.easeInOut),
              ),
              child: widget,
            );
          },
        );
}
