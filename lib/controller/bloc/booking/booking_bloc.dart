import 'package:bloc/bloc.dart';
import 'package:cocoon_app/controller/bloc/booking/booking_state.dart';
import 'package:cocoon_app/model/booked_room_model.dart';

part 'booking_event.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  final List<BookedRoom> bookings = [];
  BookedRoom? selectedRoom;
  BookingBloc() : super(BookingInitial()) {
    on<AddBooking>((event, emit) {
      bookings.add(event.bookedRoom);
      emit(BookingLoaded(List.from(bookings)));
    });

    on<SelectRoom>((event, emit) {
      selectedRoom = event.room;
    });
  }
}
