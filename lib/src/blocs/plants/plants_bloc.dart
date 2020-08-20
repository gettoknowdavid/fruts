import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruts/src/core/plants_repository.dart';
import 'package:fruts/src/models/plant.dart';
import 'package:meta/meta.dart';

part 'plants_event.dart';
part 'plants_state.dart';

class PlantsBloc extends Bloc<PlantsEvent, PlantsState> {
  final PlantsRepository repository;

  PlantsBloc({@required this.repository}) : super(PlantsLoading());

  @override
  Stream<PlantsState> mapEventToState(
    PlantsEvent event,
  ) async* {
    if (event is LoadPlants) {
      try {
        final plants = await repository.loadPlants();
        yield PlantsLoaded(plants);
      } catch (_) {
        yield PlantsNotLoaded();
      }
    }
  }
}
