import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/app.dart';
import 'package:fruts/src/blocs/cart/cart_bloc.dart';
import 'package:fruts/src/blocs/fruts_bloc_delegate.dart';
import 'package:fruts/src/blocs/plants/plants_bloc.dart';
import 'package:fruts/src/core/plants_repository.dart';
import 'package:fruts/src/database/database_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHandler repository = DatabaseHandler();

  runFruts(repository);
}

void runFruts(PlantsRepository repository) {
  BlocSupervisor.delegate = FrutsBlocDelegate();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<PlantsBloc>(
          create: (context) => PlantsBloc(
            repository: repository,
          )..add(LoadPlants()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(
            repository: repository,
          )..add(LoadCart()),
        ),
      ],
      child: App(),
    ),
  );
}
