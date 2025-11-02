import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:cocoon_app/controller/bloc/room/room_bloc.dart';
import 'package:cocoon_app/controller/bloc/room/room_event.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/widgets/hotel_available_rooms.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/widgets/hotel_detail_image.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/widgets/hotels_listview.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/widgets/review_repository.dart';
import 'package:cocoon_app/view/home/payment_screen/payment_screen_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelDetailScreen extends StatelessWidget {
  final String hotelId;
  const HotelDetailScreen({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<RoomBloc>().add(FetchRooms(hotelId));
          },
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HotelDetailImage(),
                HotelImagesHorizontal(),
                AvailableRoomsSection(),
                HotelReviewSection(hotelId: hotelId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
