part of 'tabs_bloc.dart';

abstract class TabsEvent extends Equatable {
  const TabsEvent();

  @override
  List<Object> get props => [];
}


class LoadCropsEvent extends TabsEvent {}

class UpdateTabsEvent extends TabsEvent {
  final Category category;

  UpdateTabsEvent(this.category);

  @override
  List<Object> get props => [category];

  // @override
  // String toString() => 'UpdateTabsEvent { category: $category }';
}

class UpdateCropsEvent extends TabsEvent {
  final List<Crop> plants;

  UpdateCropsEvent(this.plants);

  @override
  List<Object> get props => [plants];

  // @override
  // String toString() => 'UpdateCropsEvent { plants: $plants }';
}
