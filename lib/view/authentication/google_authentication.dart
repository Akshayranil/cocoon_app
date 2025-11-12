import 'package:cocoon_app/view/profile_setup/screen_profile_set_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

Future<bool> login() async {
  final user = await GoogleSignIn().signIn();
  GoogleSignInAuthentication userAuth = await user!.authentication;
  var credential = GoogleAuthProvider.credential(
    idToken: userAuth.idToken,
    accessToken: userAuth.accessToken,
  );
  await FirebaseAuth.instance.signInWithCredential(credential);
  return FirebaseAuth.instance.currentUser != null;
}

class GoogleAuthentication extends StatelessWidget {
  const GoogleAuthentication({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.width * 0.14,
        child: SignInButton(
          Buttons.google,
          onPressed: () async {
            bool isLoged = await login();

            if (isLoged) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProfileSetupScreen()),
              );
            }
          },
        ),
      ),
    );
  }
}
