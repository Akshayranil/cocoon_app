import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  AuthBloc() : super(AuthInitial()) {
    on<AuthLogin>(onlogin);
    on<AuthSignUp>(onsignup);
    on<AuthLogout>(onlogout);
  }

  Future<void> onlogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await auth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Login Failed'));
    }
  }

  Future<void> onsignup(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await auth.createUserWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message ?? 'Signed Up Failed'));
    }
  }

  Future<void> onlogout(AuthLogout event, Emitter<AuthState> emit) async {
    await auth.signOut();
    emit(AuthInitial());
  }
}
