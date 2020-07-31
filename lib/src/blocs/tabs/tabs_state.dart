part of 'tabs_bloc.dart';

abstract class TabsState extends Equatable {
  const TabsState();
  @override
  List<Object> get props => [];
}

class TabsLoading extends TabsState {}

class TabsLoaded extends TabsState {
  final List<Plant> plants;
  final Category category;

  TabsLoaded(this.plants, this.category);

  @override
  List<Object> get props => [plants, category];

  @override
  String toString() {
    return 'TabsLoaded { plants: $plants, category: $category }';
  }
}

class TabsNotLoaded extends TabsState {}
