import 'dart:developer';
import 'package:cocoon_app/controller/bloc/booking/booking_bloc.dart';
import 'package:cocoon_app/model/booked_room_model.dart';
import 'package:cocoon_app/view/home/payment_screen/payment_screen_main.dart';
import 'package:cocoon_app/view/home/room_detail_screen/date_picker_modal.dart';
import 'package:cocoon_app/view/home/room_detail_screen/room_description.dart';
import 'package:cocoon_app/view/home/room_detail_screen/room_guest_modal.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoon_app/controller/bloc/room/room_bloc.dart';
import 'package:cocoon_app/controller/bloc/room/room_state.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/home/user_detail_screen/user_detail_main.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class RoomDetailScreen extends StatelessWidget {
  RoomDetailScreen({super.key});

  // ✅ ValueNotifiers to hold check-in and check-out dates
  final ValueNotifier<DateTime?> checkInNotifier = ValueNotifier(null);
  final ValueNotifier<DateTime?> checkOutNotifier = ValueNotifier(null);
  final ValueNotifier<int> adultsNotifier = ValueNotifier(1);
  final ValueNotifier<int> childrenNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<RoomBloc, RoomState>(
          builder: (context, state) {
            if (state is RoomSelected) {
              final room = state.room;
              final hotel = state.hotel;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // 🔹 Carousel for room images
                        SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: PageView.builder(
                            itemCount: room.images.length,
                            itemBuilder: (context, index) {
                              return Image.network(
                                room.images[index],
                                width: double.infinity,
                                height: 250,
                                fit: BoxFit.cover,
                              );
                            },
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Center(
                            child: SmoothPageIndicator(
                              controller: PageController(),
                              count: room.images.length,
                              effect: WormEffect(
                                dotHeight: 8,
                                dotWidth: 8,
                                activeDotColor: Colors.white,
                                dotColor: Colors.white54,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 5,
                          child: CircleAvatar(
                            backgroundColor: AppColor.secondary,
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: Icon(Icons.arrow_back),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // 🏨 Hotel name and price
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            hotel.name,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "₹${room.roomPrice}/night",
                            style: const TextStyle(
                              fontSize: 20,
                              color: Colors.teal,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ✅ Check-in and Guests section
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                log('Check dates tapped');
                                final result = await showDatePickerModal(
                                  context,
                                );
                                if (result != null) {
                                  checkInNotifier.value = result['checkIn'];
                                  checkOutNotifier.value = result['checkOut'];
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      color: Colors.teal,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text("Check In & Check Out"),
                                    // ✅ Listen to value changes
                                    ValueListenableBuilder(
                                      valueListenable: checkInNotifier,
                                      builder: (context, checkIn, _) {
                                        return ValueListenableBuilder(
                                          valueListenable: checkOutNotifier,
                                          builder: (context, checkOut, _) {
                                            if (checkIn != null &&
                                                checkOut != null) {
                                              return Text(
                                                "${checkIn.day.toString().padLeft(2,'0')}/${DateFormat('MMM').format(checkIn)} - ${checkOut.day.toString().padLeft(2,'0')}/${DateFormat('MMM').format(checkOut)}",

                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            } else {
                                              return const Text(
                                                "Select dates",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            }
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () async {
                                final result = await showRoomGuestModal(
                                  context,
                                  roomType: room.type,
                                  initialAdults: adultsNotifier.value,
                                  initialChildren: childrenNotifier.value,
                                );

                                if (result != null) {
                                  adultsNotifier.value = result['adults']!;
                                  childrenNotifier.value = result['children']!;
                                }
                              },

                              child: Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  children: [
                                    const Icon(
                                      Icons.person_outline,
                                      color: Colors.teal,
                                    ),
                                    const SizedBox(height: 4),
                                    const Text("Guests & Rooms"),
                                    ValueListenableBuilder(
                                      valueListenable: adultsNotifier,
                                      builder: (context, adults, _) {
                                        return ValueListenableBuilder(
                                          valueListenable: childrenNotifier,
                                          builder: (context, children, _) {
                                            int totalGuests = adults + children;
                                            return Text(
                                              "1 Room / $totalGuests Guest${totalGuests > 1 ? 's' : ''}",
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                      Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Amenities",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Wrap(
                            spacing: 8,
                            runSpacing: 6,
                            children: room.aminities.map((amenity) {
                              return Chip(
                                label: Text(amenity),
                                backgroundColor: Colors.teal.shade100,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(height: 80),
                    RoomDescription(hotelId: hotel.id),
                   
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: () {
            final checkIn = checkInNotifier.value;
            final checkOut = checkOutNotifier.value;
            final adults = adultsNotifier.value;
            final children = childrenNotifier.value;

            if (checkIn == null || checkOut == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Please select check-in and check-out dates."),
                ),
              );
              return;
            }

            final state = context.read<RoomBloc>().state;
            if (state is RoomSelected) {
              final room = state.room;
              final hotel = state.hotel;
              final userId = FirebaseAuth.instance.currentUser?.uid ?? '';
              final nights = checkOut.difference(checkIn).inDays;
              final totalAmount = room.roomPrice * nights;
              final bookedRoom = BookedRoom(
                id: room.roomId,
                hotelUid: hotel.id,
                hotelName: hotel.name,
                location: hotel.propertyinformation,
                price: totalAmount.toDouble(),
                imageUrl: room.images.isNotEmpty ? room.images.first : '',
                checkInDate: "${checkIn.day}/${checkIn.month}/${checkIn.year}",
                checkOutDate:
                    "${checkOut.day}/${checkOut.month}/${checkOut.year}",
                guests: adults + children,
                userId: userId,
              );

              // ✅ Save selected room into BookingBloc
              context.read<BookingBloc>().add(SelectRoom(bookedRoom));

              if (adults + children == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Please select at least one guest."),
                  ),
                );
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PaymentScreen(
                    amount: totalAmount.toDouble(),
                    hotelName: hotel.name,
                  ),
                ),
              );
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColor.primary,
            foregroundColor: AppColor.secondary,
          ),
          child: const Text('Book Hotel', style: TextStyle(fontSize: 14)),
        ),
      ),
    );
  }
}
