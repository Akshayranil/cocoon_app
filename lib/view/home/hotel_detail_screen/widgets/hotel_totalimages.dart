import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelTotalimages extends StatelessWidget {
  

  const HotelTotalimages({ super.key});

  @override
  Widget build(BuildContext context) {
    final hotel = context.read<HotelBloc>().selectedHotel!;
    return Scaffold(
      appBar: AppBar(title: const Text('Hotel Images')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PageView.builder(
          itemCount: hotel.hotelimages.length,
          itemBuilder: (context, index) {
            return InteractiveViewer(
              child: Image.network(
                hotel.hotelimages[index],
                fit: BoxFit.contain,
              ),
            );
          },
        ),
      ),
    );
  }
}
