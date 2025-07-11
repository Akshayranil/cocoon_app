import 'package:cocoon_app/controller/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Account")),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailcontroller,
                  decoration: const InputDecoration(labelText: "Email"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: passwordcontroller,
                  decoration: const InputDecoration(labelText: "Password"),
                ),
                const SizedBox(height: 20),
                if (state is AuthLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () {
                      final email = emailcontroller.text.trim();
                      final password = passwordcontroller.text.trim();
                      context.read<AuthBloc>().add(AuthSignUp(email, password));
                    },
                    child: Text('Create Account'),
                  ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthInitial) {
            Navigator.pop(context);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
      ),
    );
  }
}
