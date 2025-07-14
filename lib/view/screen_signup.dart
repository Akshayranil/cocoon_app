import 'package:cocoon_app/controller/bloc/auth/auth_bloc.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Account",style: TextStyle(fontSize: 36,fontWeight: FontWeight.bold),),centerTitle: true,),
      body: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 42),
                    child: Text('Unlock exclusive stays and deals.',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: AppColor.primary ), )),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Sign up now!',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,color: AppColor.primary),)),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: emailcontroller,
                      decoration:  InputDecoration(labelText: "Username",border: OutlineInputBorder(
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
                      )
                      ),
                    ),
                  ),
            
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                    child: TextField(
                      controller: emailcontroller,
                      decoration:  InputDecoration(labelText: "Email",border: OutlineInputBorder(
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
                      )
                      ),
                    ),
                  ),
                  
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      controller: passwordcontroller,
                      decoration:  InputDecoration(labelText: "Password",border: OutlineInputBorder(
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
                      )
                      ),
                    ),
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
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(250, 40),
                        backgroundColor: AppColor.primary,
                        foregroundColor: AppColor.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                      child: Text('CREATE ACCOUNT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),),
                    ),
                ],
              ),
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
