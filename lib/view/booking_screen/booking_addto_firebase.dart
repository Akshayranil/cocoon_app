import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocoon_app/controller/bloc/booking/booking_bloc.dart';
import 'package:cocoon_app/controller/bloc/booking/booking_state.dart';
import 'package:cocoon_app/model/booked_room_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> saveBookingToHotel(BuildContext context) async {
    final state = context.read<BookingBloc>().state;

    if (state is BookingLoaded && state.bookedRooms.isNotEmpty) {
      final latestBooking = state.bookedRooms.last; // most recent booking
      final user = FirebaseAuth.instance.currentUser;

      if (user == null) return;

      try {
        
        // 🔹 Reference to hotel document
        final hotelDoc = FirebaseFirestore.instance
            .collection('hotelregistration')
            .doc(latestBooking.hotelUid); // hotel UID

        // 🔹 Save booking in hotel's subcollection
        await hotelDoc.collection('bookings').doc(latestBooking.id).set({
          'roomId': latestBooking.id,
          'hotelName': latestBooking.hotelName,
          'location': latestBooking.location,
          'price': latestBooking.price,
          'imageUrl': latestBooking.imageUrl,
          'checkInDate': latestBooking.checkInDate,
          'checkOutDate': latestBooking.checkOutDate,
          'guests': latestBooking.guests,
          'paymentStatus': 'Completed',
          'timestamp': FieldValue.serverTimestamp(),
        });

        print("✅ Booking successfully shared with hotel!");
      } catch (e) {
        print("❌ Error uploading booking: $e");
      }
    }
  }

  Future<void> saveBookingToUser(BookedRoom latestBooking) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user == null) return;

  try {
    await FirebaseFirestore.instance
        .collection('userBookings')
        .doc(user.uid)
        .collection('bookings')
        .doc(latestBooking.id)
        .set({
      'hotelName': latestBooking.hotelName,
      'location': latestBooking.location,
      'price': latestBooking.price,
      'imageUrl': latestBooking.imageUrl,
      'checkInDate': latestBooking.checkInDate,
      'checkOutDate': latestBooking.checkOutDate,
      'guests': latestBooking.guests,
      'hotelUid': latestBooking.hotelUid,
      'timestamp': FieldValue.serverTimestamp(),
    });

    print("✅ Booking successfully saved for user!");
  } catch (e) {
    print("❌ Error saving booking for user: $e");
  }
}


