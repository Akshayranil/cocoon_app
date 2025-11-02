import 'dart:developer';
import 'package:cocoon_app/controller/bloc/profile/profile_bloc.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/onboarding_screen/screen_splash.dart';
import 'package:cocoon_app/view/profile_screen/screen_help_support.dart';
import 'package:cocoon_app/view/profile_screen/screen_privacy_policy.dart';
import 'package:cocoon_app/view/profile_screen/screen_terms_conditions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // Trigger profile fetch
    if (user != null) {
      context.read<ProfileBloc>().add(FetchProfileEvent(user.uid));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: AppColor.primary,
        foregroundColor: AppColor.secondary,
        centerTitle: true,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProfileLoadedState) {
            final data = state.userData;
            final imageUrl = data['image'] ?? '';
            final name = data['name'] ?? 'No Name';
            final phone = data['phone'] ?? 'No Phone';

            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          if (imageUrl.isNotEmpty) {
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                backgroundColor: Colors.transparent,
                                insetPadding: EdgeInsets.all(10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: InteractiveViewer(
                                    panEnabled: true,
                                    minScale: 0.5,
                                    maxScale: 3.0,
                                    child: Image.network(
                                      imageUrl,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: imageUrl.isNotEmpty
                              ? NetworkImage(imageUrl)
                              : null,
                          child: imageUrl.isEmpty
                              ? const Icon(Icons.person, size: 80)
                              : null,
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // ✅ Read-only TextFields
                    TextFormField(
                      initialValue: name,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      initialValue: phone,
                      readOnly: true,
                      decoration: const InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Divider(thickness: 1.2),

                    // ✅ Menu Options
                    ListTile(
                      leading: const Icon(Icons.edit, color: AppColor.ternary),
                      title: const Text('Edit Profile'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Navigate to Edit Profile later
                      },
                    ),
                    const Divider(thickness: 1.2),
                    ListTile(
                      leading: const Icon(
                        Icons.help_outline,
                        color: AppColor.ternary,
                      ),
                      title: const Text('Help & Support'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HelpSupportScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(thickness: 1.2),
                    ListTile(
                      leading: const Icon(
                        Icons.article_outlined,
                        color: AppColor.ternary,
                      ),
                      title: const Text('Terms & Conditions'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TermsAndConditionsScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(thickness: 1.2),
                    ListTile(
                      leading: const Icon(
                        Icons.privacy_tip_outlined,
                        color: AppColor.ternary,
                      ),
                      title: const Text('Privacy Policy'),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyPolicyScreen(),
                          ),
                        );
                      },
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
            );
          }

          if (state is ProfileErrorState) {
            return Center(child: Text(state.error));
          }

          return const Center(child: Text("No profile data found."));
        },
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
