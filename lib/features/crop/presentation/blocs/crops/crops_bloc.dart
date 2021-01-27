import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fruts/core/errors/failures.dart';
import 'package:fruts/core/use_cases/no_params.dart';
import 'package:fruts/features/crop/domain/entities/crop.dart';
import 'package:fruts/features/crop/domain/use_cases/get_all_crops.dart';
import 'package:meta/meta.dart';

part 'crops_event.dart';
part 'crops_state.dart';

class CropsBloc extends Bloc<CropsEvent, CropsState> {
  CropsBloc({@required this.useCase}) : super(CropsEmpty());

  final GetAllCrops useCase;

  @override
  Stream<CropsState> mapEventToState(
    CropsEvent event,
  ) async* {
    if (event is GetAllCropsEvent) {
      final result = await useCase(NoParams());

      yield CropsLoading();

      yield* _eitherFailureOrSuccess(result);
    }
  }

  Stream<CropsState> _eitherFailureOrSuccess(
      Either<Failure, List<Crop>> failureOrSuccess) async* {
    yield failureOrSuccess.fold(
      (failure) => CropsError(message: _mapFailureToMessage(failure)),
      (crops) => CropsLoaded(crops: crops),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case DatabaseFailure:
        return 'Database Error: Failed to load last air quality from store.';
      default:
        return 'Unexpected Error';
    }
  }
}
