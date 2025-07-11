part of 'auth_bloc.dart';

@immutable
class AuthEvent {}

class AuthLogin extends AuthEvent {
  final String email;
  final String password;

  AuthLogin(this.email, this.password);
}

class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  AuthSignUp(this.email, this.password);
}

class AuthLogout extends AuthEvent {}
