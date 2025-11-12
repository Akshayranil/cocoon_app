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

class FetchUserBookings extends BookingEvent {
  final String userId;
  FetchUserBookings(this.userId);
}

class CancelBooking extends BookingEvent {
  final String userId;
  final String bookingId;
  final String hotelId;
  final double price;

  CancelBooking(this.userId, this.bookingId, this.hotelId, this.price);
}




 