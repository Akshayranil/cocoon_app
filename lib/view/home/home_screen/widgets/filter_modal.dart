import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_state.dart';
import 'package:cocoon_app/utilities/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterOptionsSheet extends StatelessWidget {
  const FilterOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    
    final selectedAmenities = <String>[];

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

            const SizedBox(height: 25),

const Text(
  'Filter by Rating',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
const SizedBox(height: 10),

// ⭐ Rating Options
...[
  {'label': '4.0 & above', 'rating': 4.0},
  {'label': '3.0 & above', 'rating': 3.0},
  {'label': '2.0 & above', 'rating': 2.0},
  {'label': '1.0 & above', 'rating': 1.0},
].map(
  (item) => ListTile(
    leading: const Icon(Icons.star, color: Colors.amber),
    title: Text(item['label'] as String),
    onTap: () {
      context.read<HotelBloc>().add(
        FilterHotelsByRating(item['rating'] as double),
      );
      Navigator.pop(context);
    },
  ),
),

const SizedBox(height: 25),
const Text(
  'Filter by Amenities',
  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
),
SizedBox(height: 10),


BlocBuilder<HotelBloc, HotelState>(
  builder: (context, state) {
    final amenities = context.read<HotelBloc>().allAmenities;
   

    return Column(
      children: amenities.map((amenity) {
        return StatefulBuilder(
          builder: (context, setState) =>
              CheckboxListTile(
                title: Text(amenity),
                value: selectedAmenities.contains(amenity),
                onChanged: (checked) {
                  setState(() {
                    checked!
                        ? selectedAmenities.add(amenity)
                        : selectedAmenities.remove(amenity);
                  });
                },
              ),
        );
      }).toList(),
    );
  },
),

ElevatedButton(
  style: ElevatedButton.styleFrom(backgroundColor: AppColor.primary,foregroundColor: AppColor.secondary),
  onPressed: () {
    if (selectedAmenities.isNotEmpty) {
      context
          .read<HotelBloc>()
          .add(FilterHotelsByAmenities(selectedAmenities));
      Navigator.pop(context);
    }
  },
  child: Text("Apply Amenity Filter"),
),


          ],
        ),
      ),
    );
  }
}
