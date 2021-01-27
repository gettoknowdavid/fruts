import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/app.dart';
import 'package:fruts/core/presentation/blocs/navigation/navigation_bloc.dart';
import 'package:fruts/dependency_injector.dart';
import 'package:fruts/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:fruts/features/crop/presentation/blocs/tabs/tabs_bloc.dart';
import 'package:fruts/dependency_injector.dart' as di;

import 'features/crop/presentation/blocs/crops/crops_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await di.init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NavigationBloc>(
          create: (context) => sl<NavigationBloc>(),
        ),
        BlocProvider<CropsBloc>(
          create: (context) => sl<CropsBloc>()..add(GetAllCropsEvent()),
        ),
        BlocProvider<TabsBloc>(
          create: (context) => sl<TabsBloc>()..add(LoadCropsEvent()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => sl<CartBloc>()..add(GetAllCartCropsEvent()),
        ),
      ],
      child: App(),
    ),
  );
}
