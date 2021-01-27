part of 'crops_bloc.dart';

abstract class CropsState extends Equatable {
  const CropsState();

  @override
  List<Object> get props => [];
}

class CropsEmpty extends CropsState {}

class CropsLoading extends CropsState {}

class CropsLoaded extends CropsState {
  final List<Crop> crops;

  CropsLoaded({@required this.crops});

  @override
  List<Object> get props => [crops];
}

class CropsError extends CropsState {
  final String message;

  CropsError({@required this.message});

  @override
  List<Object> get props => [message];
}
