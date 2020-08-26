import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animateHeight;

  bool isExpanded = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1200),
    );

    animateHeight = Tween<double>(begin: 815.0, end: 0.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    )..addListener(() {
        setState(() {});
      });

    controller.forward();
  }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   if (controller == null) {
  //     controller = ModalRoute.of(context).animation;
  //   }

  //   animateHeight = Tween<double>(begin: 0.0, end: size.height * 0.8).animate(
  //     CurvedAnimation(
  //       parent: controller,
  //       curve: Curves.easeInOut,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    print(size.height * 0.74);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Transform.translate(
              offset: Offset(0.0, -animateHeight.value),
              child: Container(
                height: 815,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(60),
                  ),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: AnimatedContainer(
          //     duration: Duration(milliseconds: 300),
          //     height: isExpanded ? size.height * 0.8 : 0.0,
          //     width: size.width,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.vertical(
          //         bottom: Radius.circular(60),
          //       ),
          //       color: Colors.white,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
