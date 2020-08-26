import 'package:equatable/equatable.dart';
import 'package:fruts/screens/screens.dart';

class NavigationState extends Equatable {
  final Screen screen;

  final List propss;
  NavigationState(this.screen, [this.propss]);

  @override
  List<Object> get props => (propss ?? [screen]);
}
