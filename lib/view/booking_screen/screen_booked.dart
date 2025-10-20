import 'package:cocoon_app/controller/bloc/booking/booking_bloc.dart';
import 'package:cocoon_app/controller/bloc/booking/booking_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookedScreen extends StatelessWidget {
  const BookedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: BlocBuilder<BookingBloc, BookingState>(
        builder: (context, state) {
          if (state is BookingLoaded && state.bookedRooms.isNotEmpty) {
            return ListView.builder(
              itemCount: state.bookedRooms.length,
              itemBuilder: (context, index) {
                final room = state.bookedRooms[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        room.imageUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(room.hotelName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(room.location),
                        Text('₹${room.price.toStringAsFixed(2)}'),
                        Text('Check-in: ${room.checkInDate}'),
                        Text('Check-out: ${room.checkOutDate}'),
                        Text('Guests: ${room.guests}'),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: Text('No bookings yet'),
          );
        },
      ),
    );
  }
}
