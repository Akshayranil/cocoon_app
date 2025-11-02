import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterOptionsSheet extends StatelessWidget {
  const FilterOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final priceRanges = [
      'Below 1000',
      '1000 - 2000',
      '2000 - 3000',
      'Above 3000',
    ];

    final residencyTypes = [
      'Hotels',
      'Resort',
      'Villa',
      'Apartment',
      'Bungalow',
      'Dormitory',
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// ---------- PRICE FILTER ----------
            const Text(
              'Filter by Price',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ...priceRanges.map(
              (range) => ListTile(
                title: Text(range),
                onTap: () {
                  context.read<HotelBloc>().add(FilterHotelsByPrice(range));
                  Navigator.pop(context); // close modal after selection
                },
              ),
            ),

            const SizedBox(height: 25),

            /// ---------- RESIDENCY TYPE FILTER ----------
            const Text(
              'Filter by Residency Type',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ...residencyTypes.map(
              (type) => ListTile(
                title: Text(type),
                onTap: () {
                  context.read<HotelBloc>().add(FilterHotelsByResidencyType(type));
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
