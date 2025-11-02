import 'package:cocoon_app/controller/bloc/favorites/favorites_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelDetailImage extends StatelessWidget {
  const HotelDetailImage({super.key});

  @override
  Widget build(BuildContext context) {
    final hotel = context.read<HotelBloc>().selectedHotel!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            // Hotel Image
            ClipRRect(
              child: Image.network(
                hotel.hotelimages.isNotEmpty
                    ? hotel.hotelimages[0]
                    : 'https://via.placeholder.com/400x200',
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
            ),

            // Back button
            Positioned(
              top: 10,
              left: 5,
              child: CircleAvatar(
                backgroundColor: AppColor.secondary,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
            ),

            // ❤️ Favorite icon on top-right corner
            Positioned(
              top: 10,
              right: 5,
              child: BlocBuilder<FavoritesBloc, FavoritesState>(
                builder: (context, favState) {
                  List favoriteHotels = [];
                  if (favState is FavoritesUpdated) {
                    favoriteHotels = favState.favoriteHotels;
                  }

                  final isFavorite = favoriteHotels.any((fav) => fav.id == hotel.id);

                  return CircleAvatar(
                    backgroundColor: Colors.grey[150],
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.green : Colors.white,
                      ),
                      onPressed: () {
                        if (isFavorite) {
                          context.read<FavoritesBloc>().add(RemoveFromFavorites(hotel));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${hotel.name} removed from favorites')),
                          );
                        } else {
                          context.read<FavoritesBloc>().add(AddToFavorites(hotel));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${hotel.name} added to favorites')),
                          );
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        // Hotel name and info
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            hotel.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, top: 1, bottom: 10),
          child: Text(
            hotel.propertyinformation,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 1, horizontal: 10),
          child: Text(
            'Description',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'The Grand Royale offers breathtaking views of the city skyline, and guests can enjoy complimentary breakfast and free Wi-Fi throughout their stay. Each room is elegantly furnished with modern amenities and luxurious bedding, while the rooftop pool and lounge provide the perfect spot to unwind after a busy day.',
          ),
        ),
      ],
    );
  }
}
