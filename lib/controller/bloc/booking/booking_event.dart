part of 'booking_bloc.dart';

abstract class BookingEvent {}

class AddBooking extends BookingEvent {
  final BookedRoom bookedRoom;
  AddBooking(this.bookedRoom, );
}

class SelectRoom extends BookingEvent {
  final BookedRoom room;

  SelectRoom(this.room);
}
