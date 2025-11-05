import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_event.dart';
import 'package:cocoon_app/controller/bloc/hotelbloc/fetchhotel_state.dart';
import 'package:cocoon_app/model/hotelmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HotelBloc extends Bloc<HotelEvent, HotelState> {
  List<Hotel> allHotels = [];
 List<String> allAmenities = [];
Map<String, String> amenityMap = {}; // id -> name

Future<void> fetchAmenities() async {
  final snapshot = await FirebaseFirestore.instance
      .collection('aminities')
      .get();

  amenityMap = {
    for (var doc in snapshot.docs)
      doc.id: doc['name'] ?? '',
  };

  allAmenities = amenityMap.values.toList();
}


  Hotel? selectedHotel;
  HotelBloc() : super(HotelInitial()) {
    on<FetchHotels>((event, emit) async {
      emit(HotelLoading());

      try {
        await fetchAmenities();
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

    on<FilterHotelsByPrice>((event, emit) {
      if (allHotels.isNotEmpty) {
        final filteredHotels = allHotels.where((hotel) {
          final price =
              int.tryParse(hotel.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;

          switch (event.priceRange) {
            case 'Below 1000':
              return price < 1000;
            case '1000 - 2000':
              return price >= 1000 && price <= 2000;
            case '2000 - 3000':
              return price > 2000 && price <= 3000;
            case 'Above 3000':
              return price > 3000;
            default:
              return true;
          }
        }).toList();

        emit(HotelLoaded(filteredHotels));
      }
    });

    on<FilterHotelsByResidencyType>((event, emit) async {
      final filteredHotels = allHotels
          .where((hotel) => hotel.type == event.residencyType)
          .toList();

      emit(HotelLoaded(filteredHotels));
    });

    on<FilterHotelsByRating>((event, emit) {
      final filteredHotels = allHotels.where((hotel) {
        return hotel.rating >= event.minRating;
      }).toList();

      emit(HotelLoaded(filteredHotels));
    });
  
  on<FilterHotelsByAmenities>((event, emit) async {
  emit(HotelLoading());

  try {
    List<Hotel> filteredHotels = [];

    for (var hotel in allHotels) {
      final roomsSnapshot = await FirebaseFirestore.instance
          .collection('hotelregistration')
          .doc(hotel.id)
          .collection('rooms')
          .get();

      bool hotelHasMatch = roomsSnapshot.docs.any((roomDoc) {
        List<String> roomAmenityIDs = List<String>.from(roomDoc['aminities'] ?? []);
        List<String> roomAmenityNames = roomAmenityIDs
            .map((id) => amenityMap[id] ?? id)
            .toList();

        return event.selectedAmenities
            .every((selectedAmenity) => roomAmenityNames.contains(selectedAmenity));
      });

      if (hotelHasMatch) {
        filteredHotels.add(hotel);
      }
    }

    emit(HotelLoaded(filteredHotels));
  } catch (e) {
    emit(HotelError("Amenities filter failed: $e"));
  }
});

    
  }
}
