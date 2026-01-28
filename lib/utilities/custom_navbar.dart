import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/booking_screen/screen_booked.dart';
import 'package:cocoon_app/view/home/home_screen/screen_home_main.dart';
import 'package:cocoon_app/view/profile_screen/screen_profile.dart';
import 'package:cocoon_app/view/saved_screen/screen_saved.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int? tabindex;
  const BottomNavBar({super.key,this.tabindex});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: tabindex??0,
      length: 4,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: AppColor.primary,
          height: 70,
          child: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Home"),
              Tab(icon: Icon(Icons.bookmark_added_sharp), text: "Booked"),
              Tab(icon: Icon(Icons.favorite), text: "Saved"),
              Tab(icon: Icon(Icons.person), text: "Profile"),
            ],
            indicatorColor: Colors.transparent,
            labelColor: AppColor.secondary,
            unselectedLabelColor: Colors.white70,
          ),
        ),
        body: TabBarView(
          children: [
            HomeScreen(),
            BookedScreen(),
            SavedScreen(),
            ProfileScreen(),
          ],
        ),
      ),
    );
  }
}
