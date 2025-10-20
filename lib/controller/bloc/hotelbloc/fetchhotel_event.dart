import 'package:cocoon_app/model/hotelmodel.dart';

abstract class HotelEvent {}

class FetchHotels extends HotelEvent {}

class SearchHotels extends HotelEvent {
  final String hotelname;

  SearchHotels(this.hotelname);
}

class SelectHotel extends HotelEvent {
  final Hotel hotel;

  SelectHotel(this.hotel);
}
