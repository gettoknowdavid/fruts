import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/screens/home_screen.dart';
import 'package:fruts/src/blocs/plants/plants_bloc.dart';
import 'package:fruts/src/blocs/tabs/tabs_bloc.dart';
import 'package:fruts/theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<TabsBloc>(
            create: (context) => TabsBloc(
              plantsBloc: context.bloc<PlantsBloc>(),
            ),
          ),
        ],
        child: HomeScreen(),
      ),
      title: 'Fruts',
      theme: FrutsTheme.theme,
    );
  }
}
