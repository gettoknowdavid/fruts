import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/constants/enums/category.dart';
import '../../../../../core/use_cases/no_params.dart';
import '../../../domain/entities/crop.dart';
import '../../../domain/use_cases/get_all_crops.dart';
import 'package:meta/meta.dart';

part 'tabs_event.dart';
part 'tabs_state.dart';

class TabsBloc extends Bloc<TabsEvent, TabsState> {
  TabsBloc({@required this.useCase}) : super(TabsLoading());

  GetAllCrops useCase;

  @override
  Stream<TabsState> mapEventToState(
    TabsEvent event,
  ) async* {
    if (event is UpdateTabsEvent) {
      yield* _mapUpdateTabsEventToState(event);
    } else if (event is UpdateCropsEvent) {
      yield* _mapUpdateCropsEventToState(event);
    } else if (event is LoadCropsEvent) {
      yield* _mapLoadCropsEventToState(event);
    }
  }

  Stream<TabsState> _mapLoadCropsEventToState(LoadCropsEvent event) async* {
    final failureOrCrops = await useCase(NoParams());
    final category = Category.all;

    yield failureOrCrops.fold(
      (failure) => TabsError(),
      (crops) => TabsLoaded(_mapCropsToCategory(crops, category), category),
    );
  }

  Stream<TabsState> _mapUpdateTabsEventToState(UpdateTabsEvent event) async* {
    final failureOrCrops = await useCase(NoParams());
    final category = event.category;

    yield failureOrCrops.fold(
      (failure) => TabsError(),
      (crops) => TabsLoaded(_mapCropsToCategory(crops, category), category),
    );
  }

  Stream<TabsState> _mapUpdateCropsEventToState(UpdateCropsEvent event) async* {
    final failureOrCrops = await useCase(NoParams());
    final currentCategory = (state as TabsLoaded).category;

    final category = state is TabsLoaded ? currentCategory : Category.all;

    yield failureOrCrops.fold(
      (failure) => TabsError(),
      (crops) => TabsLoaded(_mapCropsToCategory(crops, category), category),
    );
  }

  List<Crop> _mapCropsToCategory(List<Crop> crops, Category category) {
    if (category == Category.all) {
      return crops.toList();
    } else {
      return crops.where((crop) => crop.category == category).toList();
    }
  }
}
