part of 'crops_bloc.dart';

abstract class CropsEvent extends Equatable {
  const CropsEvent();

  @override
  List<Object> get props => [];
}

class GetAllCropsEvent extends CropsEvent {}
