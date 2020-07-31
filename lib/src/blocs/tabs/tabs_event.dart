part of 'tabs_bloc.dart';

abstract class TabsEvent extends Equatable {
  const TabsEvent();
}

class UpdateTabs extends TabsEvent {
  final Category category;

  UpdateTabs(this.category);

  @override
  List<Object> get props => [category];

  @override
  String toString() => 'UpdateTabs { category: $category }';
}

class UpdatePlants extends TabsEvent {
  final List<Plant> plants;

  UpdatePlants(this.plants);

  @override
  List<Object> get props => [plants];

  @override
  String toString() => 'UpdatePlants { plants: $plants }';
}
