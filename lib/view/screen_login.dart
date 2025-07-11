import 'package:cocoon_app/controller/bloc/auth/auth_bloc.dart';
import 'package:cocoon_app/utilities/custom_navbar.dart';
import 'package:cocoon_app/view/screen_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login '),centerTitle: true,),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(labelText: 'Email'),
                  
                ),
                SizedBox(height: 10),
                TextField(
                  controller: passwordcontroller,
                  decoration: InputDecoration(labelText: 'Password'),
                ),
                SizedBox(height: 20),
                if (state is AuthLoading)
                  const CircularProgressIndicator()
                else
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          final email = emailcontroller.text.trim();
                          final password = passwordcontroller.text.trim();
                          context.read<AuthBloc>().add(
                            AuthLogin(email, password),
                          );
                        },
                        child: Text('Login'),
                      ),
                      Row(
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ),
                              );
                            },
                            child: Text('SignUp'),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BottomNavBar()),
            );
          }
        },
      ),
    );
  }
}
