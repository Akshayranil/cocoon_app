import 'package:cocoon_app/controller/bloc/favorites/favorites_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_state.dart';
import 'package:cocoon_app/model/hotelmodel.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/hotel_detail_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelListScreen extends StatelessWidget {
  const HotelListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hotels',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: AppColor.secondary,
          ),
        ),
        backgroundColor: AppColor.primary,
      ),
      body: BlocBuilder<HotelBloc, HotelState>(
        builder: (context, state) {
          if (state is HotelLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is HotelLoaded) {
            final hotels = state.hotels;
            return BlocBuilder<FavoritesBloc, FavoritesState>(
              builder: (context, favState) {
                List<Hotel> favoriteHotels = [];
                if (favState is FavoritesUpdated) {
                  favoriteHotels = favState.favoriteHotels;
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: hotels.length,
                  itemBuilder: (context, index) {
                    final hotel = hotels[index];
                    final isFavorite = favoriteHotels.any((fav) => fav.id == hotel.id);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      height: 260,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            // Background Image
                            GestureDetector(
                              onTap: () {
                                context.read<HotelBloc>().add(SelectHotel(hotel));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HotelDetailScreen(hotelId: hotel.id,),
                                  ),
                                );
                              },
                              child: Image.network(
                                hotel.hotelimages.isNotEmpty
                                    ? hotel.hotelimages[0]
                                    : "https://w-hotels.marriott.com/wp-content/uploads/2025/08/Punta-Cana-hero-m.jpg",
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                      color: Colors.grey[300],
                                      child: Icon(
                                        Icons.broken_image,
                                        size: 50,
                                        color: Colors.grey,
                                      ),
                                    ),
                              ),
                            ),

                            // Gradient for readability
                            IgnorePointer(
                              child: Container(
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
                            ),

                            // Favorite Icon at Bottom Right
                            Align(
                              alignment: Alignment.topRight,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: GestureDetector(
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
                                        : Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),

                            // Text info at the bottom
                            IgnorePointer(
                              child: Align(
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
                                            '₹${hotel.price}',
                                           
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
                                                // hotel.rating.toString(),
                                                "4.5",
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
                );
              },
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
