import 'package:cocoon_app/model/booked_room_model.dart';

abstract class BookingState {}

class BookingInitial extends BookingState {}

class BookingLoaded extends BookingState {
  final List<BookedRoom> bookedRooms;
  BookingLoaded(this.bookedRooms);
}

class BookingLoading extends BookingState {}

class BookingError extends BookingState {
  final String error;

  BookingError(this.error);
}
