part of 'plants_bloc.dart';

abstract class PlantsEvent extends Equatable {
  const PlantsEvent();

  @override
  List<Object> get props => [];
}

class LoadPlants extends PlantsEvent {}

class AddPlants extends PlantsEvent {
  final List<Plant> plants;

  AddPlants(this.plants);

  @override
  List<Object> get props => [plants];
}
