import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fruts/core/constants/enums/screen_enum.dart';
import 'package:fruts/core/presentation/widgets/screens.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState(home));

  @override
  Stream<NavigationState> mapEventToState(
    NavigationEvent event,
  ) async* {
    try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'NavigationBloc', error: _, stackTrace: stackTrace);
      yield state;
    }
  }
}
