import 'package:cocoon_app/controller/bloc/booking/booking_bloc.dart';
import 'package:cocoon_app/controller/bloc/booking/booking_state.dart';
import 'package:cocoon_app/model/booked_room_model.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookingDetailsScreen extends StatelessWidget {
  final BookedRoom room;

  const BookingDetailsScreen({super.key, required this.room});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is BookingLoaded) {
          Navigator.pop(context);
        }
        if (state is BookingError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(14.0),
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Cancel Booking"),
                      content: const Text(
                        "Are you sure you want to cancel this booking?",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("No"),
                        ),
                        TextButton(
                          onPressed: () {
                            final uid = FirebaseAuth.instance.currentUser!.uid;
                            Navigator.pop(context);
                            context
                                .read<BookingBloc>()
                                .add(CancelBooking(uid, room.id,room.hotelUid,room.price));
                          },
                          child: const Text("Yes",
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                },
                child: const Text(
                  "Cancel Booking",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),

          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 250,
                pinned: true,
                backgroundColor: Colors.black,
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.network(
                          room.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.5)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      )
                    ],
                  ),
                  title: Text(room.hotelName,
                      style: const TextStyle(fontWeight: FontWeight.bold,color: AppColor.primary)),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(Icons.location_on,
                            "${room.location}", Colors.blue),
                        const Divider(),
                        _buildInfoRow(Icons.calendar_month,
                            "Check-In: ${room.checkInDate}", Colors.green),
                        const SizedBox(height: 6),
                        _buildInfoRow(Icons.calendar_today,
                            "Check-Out: ${room.checkOutDate}", Colors.deepOrange),
                        const SizedBox(height: 12),
                        _buildInfoRow(
                            Icons.people, "Guests: ${room.guests}", Colors.purple),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 26),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
