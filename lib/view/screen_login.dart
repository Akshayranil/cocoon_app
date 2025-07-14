import 'package:cocoon_app/controller/bloc/auth/auth_bloc.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
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
      appBar: AppBar(title: Text('Login ',style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),centerTitle: true,),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 80),
                    child: Text('Plan. Book. Relax. ',style: TextStyle(fontSize: 38,fontWeight: FontWeight.bold,color: AppColor.primary),)),
                  Padding(
                    padding: EdgeInsets.only(top: 1),
                    child: Text('Sign in to get started!!',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.primary),)),
                  Padding(
                    padding: EdgeInsets.only(top: 55),
                    child: TextField(
                      controller: emailcontroller,
                      decoration: InputDecoration(labelText: 'Email',border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: AppColor.primary,
                          width: 1.5
                        )
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Colors.grey
                        )
                      )),
                      
                      
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: passwordcontroller,
                    decoration: InputDecoration(labelText: 'Password',border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: AppColor.primary,
                        width: 1.5
                      )
                    ),
                     enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey
                      )
                    )),
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
                          
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(250, 40),
                            backgroundColor: AppColor.primary,
                            foregroundColor: AppColor.secondary,
                            shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)
                            )
                          ),
                          child: Text('LOGIN',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.only(left: 66),
                          child: Row(
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
                                child: Text('SignUp',style: TextStyle(color: AppColor.primary,fontWeight: FontWeight.bold),),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ],
              ),
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
