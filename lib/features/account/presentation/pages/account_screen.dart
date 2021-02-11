import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/app_background.dart';
import '../../../../core/presentation/widgets/fruts_app_bar.dart';

class AccountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    final _avatarRadius = width * 0.24;

    return AppBackground(
      topChild: Scaffold(
        appBar: FrutsAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 30),
              CircleAvatar(
                radius: _avatarRadius,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person_outline,
                  size: _avatarRadius,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'David Michael',
                textAlign: TextAlign.center,
                style: theme.textTheme.headline3,
              ),
              SizedBox(height: 60),
              Text(
                'Comming soon...',
                textAlign: TextAlign.center,
                style: theme.textTheme.headline5.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
