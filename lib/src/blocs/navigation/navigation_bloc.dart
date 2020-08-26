import 'dart:async';
import 'dart:developer' as developer;

import 'package:bloc/bloc.dart';
import 'package:fruts/screens/screens.dart';
import 'package:fruts/src/blocs/navigation/index.dart';

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
