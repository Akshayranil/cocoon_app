import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cocoon_app/view/onboarding_screen/screen_splash.dart';
import 'package:cocoon_app/utilities/custom_navbar.dart';

class CheckUserScreen extends StatelessWidget {
  const CheckUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading while checking user status
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          // ✅ User already logged in
          return const BottomNavBar();
        } else {
          // 🚪 Not logged in — show normal app start flow
          return const SplashScreen();
        }
      },
    );
  }
}
