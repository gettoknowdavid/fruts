part of 'navigation_bloc.dart';

class NavigationState extends Equatable {
  final Screen screen;

  final List params;

  NavigationState(this.screen, [this.params]);

  @override
  List<Object> get props => (params ?? [screen]);
}
