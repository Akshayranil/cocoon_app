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

class FilterHotelsByPrice extends HotelEvent {
  final String priceRange;
  FilterHotelsByPrice(this.priceRange);
}

class FilterHotelsByAmenity extends HotelEvent {
  final String amenity;
  FilterHotelsByAmenity(this.amenity);
}

class FilterHotelsByResidencyType extends HotelEvent {
  final String residencyType;
  FilterHotelsByResidencyType(this.residencyType);
}





