import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/room/room_bloc.dart';
import 'package:cocoon_app/controller/bloc/room/room_event.dart';
import 'package:cocoon_app/controller/bloc/room/room_state.dart';
import 'package:cocoon_app/view/home/room_detail_screen/room_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvailableRoomsSection extends StatelessWidget {
  const AvailableRoomsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final hotel = context.read<HotelBloc>().selectedHotel!;

    // 🔹 Trigger the event to fetch rooms for this hotel
    context.read<RoomBloc>().add(FetchRooms(hotel.id));

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, state) {
          if (state is RoomLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoomError) {
            return Center(child: Text(state.message));
          } else if (state is RoomLoaded) {
            final rooms = state.rooms;

            if (rooms.isEmpty) {
              return const Center(child: Text('No rooms available'));
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Available Rooms',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'More',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // Horizontal scrollable room cards
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: rooms.length,
                    itemBuilder: (context, index) {
                      final room = rooms[index];

                      return Padding(
                        padding: const EdgeInsets.only(left: 16, right: 8),
                        child: Container(
                          width: 180,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                // 🔹 Background Image
                                GestureDetector(
                                  onTap: () {
                                    context.read<RoomBloc>().add(
                                      SelectRoom(room,hotel),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            RoomDetailScreen(),
                                      ),
                                    );
                                  },
                                  child: Image.network(
                                    room.images.isNotEmpty
                                        ? room.images.first
                                        : 'https://via.placeholder.com/180x230',
                                    height: 230,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),

                                // 🔹 Gradient overlay (for better text visibility)
                                IgnorePointer(
                                  child: Container(
                                    height: 230,
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.6),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                // 🔹 Text content
                                IgnorePointer(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          room.type,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "₹${room.roomPrice.toString()} / night",
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        // ✅ Show amenities properly
                                        Wrap(
                                          spacing: 4,
                                          runSpacing: 2,
                                          children: room.aminities.map((
                                            amenity,
                                          ) {
                                            return Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 2,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.white24,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(
                                                amenity,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                        ),

                                        const SizedBox(height: 2),
                                        Text(
                                          "Extra Bed: ${room.extraBedType}",
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }

          // Default state
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
