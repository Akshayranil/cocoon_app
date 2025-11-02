import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_bloc.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:cocoon_app/view/home/home_screen/widgets/filter_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsetsGeometry.only(left: 20, top: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Kannur , Kerala',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 20, top: 10, right: 10),
         child: Row(
          children: [
             Expanded(
               child: TextField(
                           decoration: InputDecoration(
                hintText: 'Search hotel,location etc',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: Icon(Icons.search),
                           ),
                           onChanged: (value) {
                context.read<HotelBloc>().add(SearchHotels(value));
                
                           },
                         ),
             ),
             SizedBox(width: 10,),
             InkWell(
                onTap: () {
                  
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => const FilterOptionsSheet(),
                  );
                },
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: const Icon(Icons.filter_list, size: 28),
                ),
              ),
          ],
         ),
        ),
      ],
    );
  }
}
