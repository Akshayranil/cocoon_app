part of 'auth_bloc.dart';

@immutable
class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final User user; // add the user
  AuthSuccess(this.user);

  @override
  List<Object?> get props => [user];
}


class AuthFailure extends AuthState {
  final String error;
  AuthFailure(this.error);
  @override
 
  List<Object?> get props => [error];
}
