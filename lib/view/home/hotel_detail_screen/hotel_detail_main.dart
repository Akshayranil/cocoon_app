import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/widgets/hotel_available_rooms.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/widgets/hotel_detail_image.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/widgets/hotels_listview.dart';
import 'package:cocoon_app/view/home/payment_screen/payment_screen_main.dart';
import 'package:flutter/material.dart';


class HotelDetailScreen extends StatelessWidget {
  const HotelDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             HotelDetailImage(),
             HotelImagesHorizontal(),
             AvailableRoomsSection()
             ],
          ),
        ),
      ),
     
    );
  }
}
