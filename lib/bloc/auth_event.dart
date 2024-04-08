part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AddUser extends AuthEvent {
  final String name;
  final String phone;

  AddUser(this.name, this.phone);
}
