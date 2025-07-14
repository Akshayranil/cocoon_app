import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_state.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelListScreen extends StatelessWidget {
  const HotelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hotels',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26,color: AppColor.secondary)),backgroundColor: AppColor.primary,),
      body: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          if (state is HotelLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HotelLoaded) {
            final hotels = state.hotels;

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: hotels.length,
              itemBuilder: (context, index) {
  final hotel = hotels[index];
return Container(
  margin: const EdgeInsets.only(bottom: 16),
  height: 260,
  child: ClipRRect(
    borderRadius: BorderRadius.circular(16),
    child: Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.network(
          hotel.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey[300],
            child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
          ),
        ),

        // Gradient for readability
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.75),
              ],
            ),
          ),
        ),

        // Favorite Icon at Bottom Right
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: () {
                // TODO: Add BLoC event or local toggle logic
              },
              child: Icon(
                Icons.favorite_border, // Replace with Icons.favorite if it's selected
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),

        // Text info at the bottom
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  hotel.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  hotel.location,
                  style: const TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${hotel.price.toStringAsFixed(0)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, size: 16, color: Colors.amber),
                        const SizedBox(width: 4),
                        Text(
                          hotel.rating.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);


}

            );
          } else if (state is HotelError) {
            return Center(child: Text(state.message));
          }

          return Container();
        },
      ),
    );
  }
}
