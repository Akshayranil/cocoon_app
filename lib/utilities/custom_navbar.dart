import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/screen_booked.dart';
import 'package:cocoon_app/view/screen_home.dart';
import 'package:cocoon_app/view/screen_profile.dart';
import 'package:cocoon_app/view/screen_saved.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 4, 
    child: Scaffold(
      bottomNavigationBar: Container(
        color: AppColor.primary,
        height: 70,
        child: TabBar(tabs: [
          Tab(icon: Icon(Icons.home),
          text: "Home",
          ),
          Tab(icon: Icon(Icons.bookmark_added_sharp),
          text: "Booked",),
          Tab(icon: Icon(Icons.favorite),),
          Tab(icon: Icon(Icons.person),)
        ],
        indicatorColor: Colors.transparent,
        labelColor: AppColor.secondary,
        unselectedLabelColor: Colors.grey,),
      ),
      body: TabBarView(children: [
        HomeScreen(),
        BookedScreen(),
        SavedScreen(),
        ProfileScreen()
      ]),
    ));
  }
}