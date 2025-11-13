import 'package:cocoon_app/controller/bloc/favorites/favorites_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_state.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/hotel_detail_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScreenDiscountOffer extends StatefulWidget {
  const ScreenDiscountOffer({super.key});

  @override
  State<ScreenDiscountOffer> createState() => _ScreenDiscountOfferState();
}

class _ScreenDiscountOfferState extends State<ScreenDiscountOffer> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: Text(
            'Best offers for you',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        SizedBox(
          height: 240,
          child: BlocBuilder<HotelBloc, HotelState>(
            builder: (context, state) {
              if (state is HotelLoading) {
                return Center(child: CircularProgressIndicator());
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
                return BlocBuilder<FavoritesBloc, FavoritesState>(
                  builder: (context, favState) {
                    List favoriteHotels = [];
                    if (favState is FavoritesUpdated) {
                      favoriteHotels = favState.favoriteHotels;
                    }

                    return Stack(
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          itemCount: hotels.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentPage = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            final hotel = hotels[index];
                            final isFavorite = favoriteHotels
                                .any((fav) => fav.id == hotel.id);

                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              child: GestureDetector(
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      // Hotel Image
                                      Image.network(
                                        hotel.hotelimages.isNotEmpty
                                            ? hotel.hotelimages[0]
                                            : "https://w-hotels.marriott.com/wp-content/uploads/2025/08/Punta-Cana-hero-m.jpg",
                                        fit: BoxFit.cover,
                                      ),

                                      // Dark gradient overlay
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.black.withOpacity(0.25),
                                              Colors.black.withOpacity(0.6),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Favorite Icon
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              if (isFavorite) {
                                                context
                                                    .read<FavoritesBloc>()
                                                    .add(RemoveFromFavorites(hotel));
                                              } else {
                                                context
                                                    .read<FavoritesBloc>()
                                                    .add(AddToFavorites(hotel));
                                              }
                                            },
                                            child: Icon(
                                              isFavorite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: isFavorite
                                                  ? Colors.greenAccent
                                                  : Colors.white,
                                              size: 28,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Hotel Info & Dots
                                      Positioned(
                                        bottom: 12,
                                        left: 16,
                                        right: 16,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Hotel Name
                                            Text(
                                              hotel.name,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black38,
                                                    offset: Offset(0, 1),
                                                    blurRadius: 2,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            SizedBox(height: 4),

                                            // Property Info
                                            Text(
                                              hotel.propertyinformation,
                                              style: TextStyle(
                                                color: Colors.white70,
                                                fontSize: 14,
                                                shadows: [
                                                  Shadow(
                                                    color: Colors.black38,
                                                    offset: Offset(0, 1),
                                                    blurRadius: 2,
                                                  ),
                                                ],
                                              ),
                                            ),

                                            SizedBox(height: 10),

                                            // Dots indicator
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: List.generate(hotels.length, (dotIndex) {
                                                return AnimatedContainer(
                                                  duration: Duration(milliseconds: 300),
                                                  margin: EdgeInsets.symmetric(horizontal: 4),
                                                  width: _currentPage == dotIndex ? 12 : 8,
                                                  height: _currentPage == dotIndex ? 12 : 8,
                                                  decoration: BoxDecoration(
                                                    color: _currentPage == dotIndex
                                                        ? Colors.white
                                                        : Colors.white54,
                                                    shape: BoxShape.circle,
                                                  ),
                                                );
                                              }),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              } else if (state is HotelError) {
                return Center(child: Text(state.message));
              }

              return Container();
            },
          ),
        ),
      ],
    );
  }
}
