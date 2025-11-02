import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoomDescription extends StatelessWidget {
  final String hotelId;

  const RoomDescription({super.key, required this.hotelId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('hotelregistration')
          .doc(hotelId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.data() as Map<String, dynamic>;
        final double lat = data['latitude'];
        final double lng = data['longitude'];
        final String name = data['name'] ?? "Hotel";

        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🏨 Hotel Description
                const Text(
                  'About the Hotel',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Nestled in the heart of the city, Hotel Cocoon Paradise offers a perfect blend of comfort, luxury, and convenience. Designed for both business and leisure travelers, the hotel features elegant rooms with modern amenities, a multi-cuisine restaurant, a rooftop swimming pool, and 24/7 room service.\n\nGuests can enjoy a relaxing stay with facilities such as free Wi-Fi, a fully equipped fitness center, and a serene spa. Located just minutes away from popular attractions, shopping centers, and transport hubs, Hotel Cocoon Paradise ensures a seamless experience for every guest.',
                  style: TextStyle(height: 1.5),
                ),
                

                const SizedBox(height: 25),

                // 📍 Location Section
                const Text(
                  "Location",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: SizedBox(
                    height: 200, // ✅ Fixed height prevents infinite size error
                    width: double.infinity,
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(lat, lng),
                        zoom: 15,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId('hotel'),
                          position: LatLng(lat, lng),
                          infoWindow: InfoWindow(title: name),
                        ),
                      },
                      zoomControlsEnabled: false,
                      myLocationButtonEnabled: false,
                      scrollGesturesEnabled: false,
                      tiltGesturesEnabled: false,
                      rotateGesturesEnabled: false,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

               
                
              ],
            ),
          ),
        );
      },
    );
  }
}
