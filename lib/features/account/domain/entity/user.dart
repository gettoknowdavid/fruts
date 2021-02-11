import 'package:equatable/equatable.dart';
import 'user_payment_method.dart';

class User extends Equatable {
  final int id;
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final UserPaymentMethod card;

  User(this.id, this.firstName, this.lastName, this.username, this.email, this.card);

  @override
  List<Object> get props => throw UnimplementedError();

}