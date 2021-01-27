import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Params extends Equatable {
  Params({@required this.id});

  final int id;

  @override
  List<Object> get props => [id];
}
