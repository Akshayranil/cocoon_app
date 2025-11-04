import 'package:cocoon_app/controller/bloc/favorites/favorites_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:cocoon_app/model/hotelmodel.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/hotel_detail_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<FavoritesBloc>().add(LoadFavorites());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Saved Hotels',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
            color: AppColor.secondary,
          ),
        ),
        backgroundColor: AppColor.primary,
      ),
      body: BlocBuilder<FavoritesBloc, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesInitial) {
            return const Center(
              child: Text(
                'No favorite hotels yet',
                style: TextStyle(fontSize: 18),
              ),
            );
          }
          if (state is FavoritesUpdated) {
            final favoriteHotels = state.favoriteHotels;

            if (favoriteHotels.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/coccon3-removebg-preview.png', // ✅ Your image path
                      height: 150,
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "You haven't made any favorites yet.",
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

            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: favoriteHotels.length,
              itemBuilder: (context, index) {
                final hotel = favoriteHotels[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  height: 260,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: GestureDetector(
                      behavior: HitTestBehavior
                          .translucent, // ✅ allows underlying taps
                      onTap: () {
                        context.read<HotelBloc>().add(SelectHotel(hotel));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HotelDetailScreen(hotelId: hotel.id),
                          ),
                        );
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Background Image
                          Image.network(
                            hotel.hotelimages.isNotEmpty
                                ? hotel.hotelimages[0]
                                : "https://w-hotels.marriott.com/wp-content/uploads/2025/08/Punta-Cana-hero-m.jpg",
                            fit: BoxFit.cover,
                          ),

                          // Gradient
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

                          // Favorite icon (tap overrides navigation)
                          Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: GestureDetector(
                                onTap: () {
                                  context.read<FavoritesBloc>().add(
                                    RemoveFromFavorites(hotel),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        '${hotel.name} removed from favorites',
                                      ),
                                    ),
                                  );
                                },
                                child: const Icon(
                                  Icons.favorite,
                                  color: Colors.green,
                                  size: 30,
                                ),
                              ),
                            ),
                          ),

                          // Info area (still tappable → goes to details)
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
                                    hotel.propertyinformation,
                                    style: const TextStyle(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
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
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
