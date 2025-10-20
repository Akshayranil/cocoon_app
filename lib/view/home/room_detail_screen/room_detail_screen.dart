import 'dart:developer';
import 'package:cocoon_app/controller/bloc/booking/booking_bloc.dart';
import 'package:cocoon_app/model/booked_room_model.dart';
import 'package:cocoon_app/view/home/room_detail_screen/date_picker_modal.dart';
import 'package:cocoon_app/view/home/room_detail_screen/room_guest_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocoon_app/controller/bloc/room/room_bloc.dart';
import 'package:cocoon_app/controller/bloc/room/room_state.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/home/user_detail_screen/user_detail_main.dart';

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
      body: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is RoomSelected) {
            final room = state.room;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    room.images.isNotEmpty
                        ? room.images.first
                        : 'https://via.placeholder.com/300x200',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 16),

                  // 🏨 Hotel name and price
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Paris Hotel",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "₹${room.roomPrice}",
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
                              final result = await showDatePickerModal(context);
                              if (result != null) {
                                checkInNotifier.value = result['checkIn'];
                                checkOutNotifier.value = result['checkOut'];
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey.shade300),
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
                                              "${checkIn.day}/${checkIn.month} - ${checkOut.day}/${checkOut.month}",
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
                                border: Border.all(color: Colors.grey.shade300),
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

                  const SizedBox(height: 80),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
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

    final bookedRoom = BookedRoom(
      id: room.roomId,
      hotelName: "Paris Hotel",
      location: "Paris",
      price: room.roomPrice.toDouble(),
      imageUrl: room.images.isNotEmpty ? room.images.first : '',
      checkInDate: "${checkIn.day}/${checkIn.month}/${checkIn.year}",
      checkOutDate: "${checkOut.day}/${checkOut.month}/${checkOut.year}",
      guests: adults + children,
    );

    // ✅ Save selected room into BookingBloc
    context.read<BookingBloc>().add(SelectRoom(bookedRoom));
  }

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
              MaterialPageRoute(builder: (context) => const UserDetailScreen()),
            );
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
