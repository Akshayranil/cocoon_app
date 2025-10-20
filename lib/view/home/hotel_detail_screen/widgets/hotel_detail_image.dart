import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
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
        ClipRRect(child: Image.network(hotel.hotelimages[0],height: MediaQuery.of(context).size.height*0.3,width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),),
        Padding(padding: EdgeInsets.symmetric(horizontal: 10), child: Text(hotel.name,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 28),)),
        Padding(
          padding: const EdgeInsets.only(left: 10,top: 1,bottom: 10),
          child: Text(hotel.propertyinformation,style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        Padding(
          padding:  const EdgeInsets.symmetric(vertical: 1,horizontal: 10),
          child: Text('Discription',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'The Grand Royale offers breathtaking views of the city skyline, and guests can enjoy complimentary breakfast and free Wi-Fi throughout their stay. Each room is elegantly furnished with modern amenities and luxurious bedding, while the rooftop pool and lounge provide the perfect spot to unwind after a busy day. ',
          ),
        ),
      ],
    );
  }
}
