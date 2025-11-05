import 'package:cocoon_app/controller/bloc/favorites/favorites_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_state.dart';
import 'package:cocoon_app/model/hotelmodel.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/home/home_screen/widgets/screen_highlyrated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetHighlyRatedHotels extends StatelessWidget {
  const WidgetHighlyRatedHotels({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<FavoritesBloc>().add(LoadFavorites()); 
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: const Text(
            'Highest rated hotels',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),

        BlocBuilder<HotelBloc, HotelState>(
          builder: (context, state) {
            if (state is HotelLoaded) {
              final hotels = state.hotels;

              // Wrap list in FavoritesBloc builder so icon updates when state changes
              return BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, favState) {
                  List<Hotel> favoriteHotels = [];
                  if (favState is FavoritesUpdated) {
                    favoriteHotels = favState.favoriteHotels;
                  }

                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: hotels.length,
                    itemBuilder: (context, index) {
                      final hotel = hotels[index];
                      final isFavorite = favoriteHotels.any((fav) => fav.id == hotel.id);

                      return HotelListTile(
                        hotel: hotel,
                        imageUrl: hotel.hotelimages[0],
                        name: hotel.name,
                        location: hotel.propertyinformation,
                        rating: hotel.rating.toStringAsFixed(1),
                        price: hotel.price,
                        isFavorite: isFavorite,
                        onLikeToggle: () {
                          if (isFavorite) {
                            context.read<FavoritesBloc>().add(
                                  RemoveFromFavorites(hotel),
                                );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '${hotel.name} removed from favorites')),
                            );
                          } else {
                            context.read<FavoritesBloc>().add(
                                  AddToFavorites(hotel),
                                );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '${hotel.name} added to favorites')),
                            );
                          }
                        },
                      );
                    },
                  );
                },
              );
            } else if (state is HotelLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HotelError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }
}
