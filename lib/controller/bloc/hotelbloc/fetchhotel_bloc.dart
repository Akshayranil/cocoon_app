import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_state.dart';
import 'package:cocoon_app/model/hotelmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  List<Hotel> allHotels = [];
  Hotel? selectedHotel;
  HotelBloc() : super(HotelInitial()) {
    on<FetchHotels>((event, emit) async {
      emit(HotelLoading());

      try {
        final query = await FirebaseFirestore.instance
            .collection('hotelregistration')
            .where('status', isEqualTo: 'accepted') // ✅ filter here
            .get();

        allHotels = query.docs.map((doc) {
          return Hotel.fromMap(doc.data(), doc.id);
        }).toList();

        emit(HotelLoaded(allHotels));
      } catch (e) {
        emit(HotelError('Failed to fetch hotels: $e'));
      }
    });

    on<SearchHotels>((event, emit) {
      final searchtext = event.hotelname.toLowerCase();
      final filteredhotel = allHotels.where((hotel) {
        final name = hotel.name.toLowerCase();
        final city = hotel.propertyinformation.toLowerCase();
        return name.contains(searchtext) || city.contains(searchtext);
      }).toList();
      emit(HotelLoaded(filteredhotel));
    });

    on<SelectHotel>((event, emit) {
      selectedHotel = event.hotel;
    });
  }
}
