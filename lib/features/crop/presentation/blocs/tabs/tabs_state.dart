part of 'tabs_bloc.dart';

abstract class TabsState extends Equatable {
  const TabsState();
  @override
  List<Object> get props => [];
}

class TabsLoading extends TabsState {}

class TabsLoaded extends TabsState {
  final List<Crop> crops;
  final Category category;

  TabsLoaded(this.crops, this.category);

  @override
  List<Object> get props => [crops, category];

  // @override
  // String toString() {
  //   return 'TabsLoaded { plants: $crops, category: $category }';
  // }
}

class TabsError extends TabsState {}
