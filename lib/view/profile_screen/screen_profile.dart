import 'dart:developer';

import 'package:cocoon_app/controller/bloc/auth/auth_bloc.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/onboarding_screen/screen_getstarted.dart';
import 'package:cocoon_app/view/onboarding_screen/screen_splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.secondary,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 60,
                  child: Icon(Icons.person, size: 80),
                ),
              ),
              // Top Items
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: ListTile(
                  leading: const Icon(Icons.edit, color: AppColor.ternary),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
              ),
              const Divider(thickness: 1.2),
              ListTile(
                leading: const Icon(
                  Icons.notifications,
                  color: AppColor.ternary,
                ),
                title: const Text('Notification'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              const Divider(thickness: 1.2),
              ListTile(
                leading: const Icon(Icons.business, color: AppColor.ternary),
                title: const Text('Register as Hotel Owner'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),

              // Bottom Items
              Padding(
                padding: EdgeInsets.only(top: 50),
                child: ListTile(
                  leading: const Icon(
                    Icons.help_outline,
                    color: AppColor.ternary,
                  ),
                  title: const Text('Help & Support'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {},
                ),
              ),
              const Divider(thickness: 1.2),
              ListTile(
                leading: const Icon(
                  Icons.article_outlined,
                  color: AppColor.ternary,
                ),
                title: const Text('Terms & Conditions'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
              const Divider(thickness: 1.2),
              ListTile(
                leading: const Icon(
                  Icons.privacy_tip_outlined,
                  color: AppColor.ternary,
                ),
                title: const Text('Privacy Policy'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),

              const Divider(thickness: 1.2),

              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.red,
                ),
                onTap: () async {
                  bool isLogedout = await logout();
                  if (isLogedout) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SplashScreen(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e) {
      log('Logout error : $e');
      return false;
    }
  }
}
