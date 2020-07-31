part of 'plants_bloc.dart';

abstract class PlantsState extends Equatable {
  const PlantsState();

  @override
  List<Object> get props => [];
}

class PlantsLoading extends PlantsState {}

class PlantsLoaded extends PlantsState {
  final List<Plant> plants;

  PlantsLoaded(this.plants);

  @override
  List<Object> get props => [plants];

  @override
  String toString() {
    return 'PlantsLoaded { plants: $plants }';
  }
}

class PlantsNotLoaded extends PlantsState {}
