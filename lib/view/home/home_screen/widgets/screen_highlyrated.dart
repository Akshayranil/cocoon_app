import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:cocoon_app/model/hotelmodel.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/hotel_detail_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelListTile extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String location;
  final String rating;
  final String price;
  final bool isFavorite;
  final VoidCallback onLikeToggle;
  final Hotel hotel;

  const HotelListTile({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.location,
    required this.rating,
    required this.price,
    required this.isFavorite,
    required this.onLikeToggle,
    required this.hotel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 140, // 🔼 Increased card height
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            GestureDetector(
              onTap: () {
                context.read<HotelBloc>().add(SelectHotel(hotel));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HotelDetailScreen(hotelId: hotel.id),
                  ),
                );
                // context.read<HotelBloc>().add(FetchHotels());
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl.isNotEmpty
                      ? imageUrl
                      : 'https://via.placeholder.com/120',
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 30),

            // Hotel info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(location, style: const TextStyle(fontSize: 13)),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        (hotel.reviewCount == 0)
                            ? "New"
                            : hotel.rating.toStringAsFixed(1),
                        style: const TextStyle(color: AppColor.ternary),
                      ),
                      const SizedBox(width: 60),
                      Text(
                        '₹${price.toString()}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.green : Colors.grey,
              ),
              onPressed: onLikeToggle,
            ),
          ],
        ),
      ),
    );
  }
}
