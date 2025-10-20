import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/view/home/hotel_detail_screen/widgets/hotel_totalimages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelImagesHorizontal extends StatelessWidget {
  

  const HotelImagesHorizontal({ super.key});

  @override
  Widget build(BuildContext context) {
    final hotel = context.read<HotelBloc>().selectedHotel!;
    
    return Padding(
      padding:  EdgeInsets.only(left: 10,top: 10),
      child: SizedBox(
        height: 100,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: hotel.hotelimages.length > 4 ? 4 : hotel.hotelimages.length,
          itemBuilder: (context, index) {
            // For the last visible image, show 5+ overlay
            if (index == 3 && hotel.hotelimages.length > 4) {
              return GestureDetector(
                onTap: () {
                  // Open full screen gallery
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HotelTotalimages(),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(hotel.hotelimages[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Container(
                      width: 120,
                      height: 120,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '+${hotel.hotelimages.length - 3}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                margin: const EdgeInsets.only(right: 8),
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(hotel.hotelimages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
  
}
