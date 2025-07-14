import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_state.dart';
import 'package:cocoon_app/model/hotelmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  HotelBloc() : super(HotelInitial()) {
    on<FetchHotels>((event, emit) async {
      emit(HotelLoading());

      try {
        final query = await FirebaseFirestore.instance.collection('hotels').get();

        List<Hotel> hotels = query.docs.map((doc) {
          return Hotel.fromMap(doc.data(), doc.id);
        }).toList();

        emit(HotelLoaded(hotels));
      } catch (e) {
        emit(HotelError('Failed to fetch hotels'));
      }
    });
  }
}
