import 'package:flutter/material.dart';
import 'theme.dart';
import 'core/presentation/widgets/screen_controller.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ScreenController(),
      title: 'Fruts',
      theme: FrutsTheme.theme,
    );
  }
}
