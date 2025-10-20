import 'package:cocoon_app/view/home/home_screen/widgets/refresh_indicator.dart';
import 'package:cocoon_app/view/home/home_screen/widgets/screen_discount_offer.dart';
import 'package:cocoon_app/view/home/home_screen/widgets/search_field.dart';
import 'package:cocoon_app/view/home/home_screen/widgets/widget_highly_rated_hotels.dart';
import 'package:cocoon_app/view/home/home_screen/widgets/widget_hotel_near_you.dart';
import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget { 
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh:() => onRefresh(context),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SearchField(),
                ScreenDiscountOffer(),
                WidgetHotelNearYou(),
                WidgetHighlyRatedHotels(),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}
