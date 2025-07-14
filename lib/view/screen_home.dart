import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_state.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:cocoon_app/view/screen_highlyrated.dart';
import 'package:cocoon_app/view/screen_hotellist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsetsGeometry.only(left: 35, top: 20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Kannur , Kerala',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30, top: 10, right: 30),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search hotel,location etc',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Icon(Icons.search)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, left: 30),
                child: Text(
                  'Best offers for you',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    children: [
                      GestureDetector(
                        onTap: () {
                          
                        },
                        child: Image.asset('assets/resort.jpg')),
                      Padding(
                        padding: EdgeInsets.only(left: 30, top: 20),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Upto 40 % OFF *\n\n',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    'Discounts that feels \n like a vacation.',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
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
              Padding(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hotel near you',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HotelListScreen(),
                          ),
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

      return SizedBox(
        height: 260,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: hotels.length,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (context, index) {
            final hotel = hotels[index];
            return Container(
              width: MediaQuery.of(context).size.width * 0.6,
              margin: const EdgeInsets.only(right: 16),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Image
                    Image.network(
                      hotel.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 50),
                      ),
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
                    // Favorite icon
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite_border, color: Colors.white),
                      ),
                    ),
                    // Text Info
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(hotel.name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(hotel.location,
                                style: const TextStyle(color: Colors.white70)),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('₹${hotel.price.toStringAsFixed(0)}',
                                    style: const TextStyle(color: Colors.white)),
                                Row(
                                  children: [
                                    const Icon(Icons.star,
                                        size: 16, color: Colors.amber),
                                    const SizedBox(width: 4),
                                    Text(hotel.rating.toString(),
                                        style: const TextStyle(color: Colors.white)),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
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


Padding(
  padding: EdgeInsets.all(20),
  child: Text('Highest rated hotels',style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),)),

      BlocBuilder<HotelBloc, HotelState>(
  builder: (context, state) {
    if (state is HotelLoaded) {
      final hotels = state.hotels;
      return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: hotels.length,
        itemBuilder: (context, index) {
          final hotel = hotels[index];
          return HotelListTile(
            imageUrl: hotel.imageUrl,
            name: hotel.name,
            location: hotel.location,
            rating: hotel.rating,
            price: hotel.price,
            isLiked: false, // Replace with actual favorite state
            onLikeToggle: () {
              // TODO: handle like toggle (update state or database)
            },
          );
        },
      );
    } else if (state is HotelLoading) {
      return Center(child: CircularProgressIndicator());
    } else if (state is HotelError) {
      return Center(child: Text(state.message));
    } else {
      return SizedBox.shrink();
    }
  },
),

            ],
          ),
        ),
      ),
    );
  }
}
