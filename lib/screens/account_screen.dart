import 'package:flutter/material.dart';
import 'package:fruts/widgets/app_background.dart';
import 'package:fruts/widgets/fruts_app_bar.dart';

class AccountScreen extends StatefulWidget {
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: AppBackground(
        topChild: Scaffold(
          appBar: FrutsAppBar(title: 'ACCOUNT'),
        ),
      ),
    );
  }
}
