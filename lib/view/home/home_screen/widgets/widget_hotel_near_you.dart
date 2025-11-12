import 'dart:developer';

import 'package:cocoon_app/controller/bloc/favorites/favorites_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_state.dart';
import 'package:cocoon_app/model/hotelmodel.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/home/home_screen/widgets/screen_hotellist.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/hotel_detail_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetHotelNearYou extends StatelessWidget {
  const WidgetHotelNearYou({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesBloc>().add(LoadFavorites());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hotel near you',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HotelListScreen()),
                  );
                },
                child: Text('See All'),
              ),
            ],
          ),
        ),
        BlocBuilder<HotelBloc, HotelState>(
          builder: (context, state) {
            if (state is HotelLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HotelLoaded) {
              final hotels = state.hotels;
              if (hotels.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/notfound-removebg-preview.png', // your placeholder image
                        height: 150,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "No data available at the moment",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                );
              }

              return SizedBox(
                height: 260,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: hotels.length,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemBuilder: (context, index) {
                    final hotel = hotels[index];
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.46,
                      margin: const EdgeInsets.only(right: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Image
                            GestureDetector(
                              onTap: () {
                                context.read<HotelBloc>().add(
                                  SelectHotel(hotel),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HotelDetailScreen(hotelId: hotel.id),
                                  ),
                                );
                              },
                              child: Image.network(
                                hotel.hotelimages.isNotEmpty
                                    ? hotel.hotelimages[0]
                                    : 'https://w-hotels.marriott.com/wp-content/uploads/2025/08/Punta-Cana-hero-m.jpg',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: Colors.grey[300],
                                      child: const Icon(
                                        Icons.broken_image,
                                        size: 50,
                                      ),
                                    ),
                              ),
                            ),
                            // Gradient
                            IgnorePointer(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      // ignore: deprecated_member_use
                                      Colors.black.withOpacity(0.75),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            // Favorite icon
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BlocBuilder<FavoritesBloc, FavoritesState>(
                                  builder: (context, favState) {
                                    List<Hotel> favoriteHotels = [];

                                    if (favState is FavoritesUpdated) {
                                      favoriteHotels = favState.favoriteHotels;
                                    }

                                    final isFavorite = favoriteHotels.any(
                                      (fav) => fav.id == hotel.id,
                                    );

                                    return GestureDetector(
                                      onTap: () {
                                        if (isFavorite) {
                                          context.read<FavoritesBloc>().add(
                                            RemoveFromFavorites(hotel),
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${hotel.name} removed from favorites',
                                              ),
                                            ),
                                          );
                                        } else {
                                          context.read<FavoritesBloc>().add(
                                            AddToFavorites(hotel),
                                          );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${hotel.name} added to favorites',
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      child: Icon(
                                        isFavorite
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isFavorite
                                            ? Colors.green
                                            : AppColor.secondary,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),

                            // Text Info
                            IgnorePointer(
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        hotel.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        hotel.propertyinformation,
                                        style: const TextStyle(
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "₹${hotel.price}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.star,
                                                size: 16,
                                                color: Colors.amber,
                                              ),
                                              const SizedBox(width: 4),
                                              Text(
                                                (hotel.reviewCount == 0)
                                                    ? "New"
                                                    : hotel.rating
                                                          .toStringAsFixed(1),
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is HotelError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox();
            }
          },
        ),
      ],
    );
  }
}
