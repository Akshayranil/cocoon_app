import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

    on<FetchUserBookings>((event, emit) async {
  emit(BookingLoading());
  try {
    final snapshot = await FirebaseFirestore.instance
    .collection('userBookings')
    .doc(event.userId)
    .collection('bookings')
    .get();


    final List<BookedRoom> fetchedBookings = snapshot.docs.map((doc) {
      final data = doc.data();
      return BookedRoom(
        userId:data['userId'] ??'',
        id: doc.id,
        hotelName: data['hotelName'],
        location: data['location'],
        price: (data['price'] ?? 0).toDouble(),
        imageUrl: data['imageUrl'],
        checkInDate: data['checkInDate'],
        checkOutDate: data['checkOutDate'],
        guests: data['guests'],
        hotelUid: data['hotelUid'],
        userName: data['userName'],
        userPhone: data['userPhone']
      );
    }).toList();

    emit(BookingLoaded(fetchedBookings));
  } catch (e) {
    emit(BookingError('Failed to load bookings: $e'));
  }
});

on<CancelBooking>((event, emit) async {
  emit(BookingLoading());
  
  try {
    // Delete booking
    await FirebaseFirestore.instance
        .collection('userBookings')
        .doc(event.userId)
        .collection('bookings')
        .doc(event.bookingId)
        .delete();

    // ✅ Refresh after deletion and wait for loading to finish
    final snapshot = await FirebaseFirestore.instance
        .collection('userBookings')
        .doc(event.userId)
        .collection('bookings')
        .get();

    final List<BookedRoom> fetchedBookings = snapshot.docs.map((doc) {
      final data = doc.data();
      return BookedRoom(
        userId: data['userId'] ?? '',
        id: doc.id,
        hotelName: data['hotelName'],
        location: data['location'],
        price: (data['price'] ?? 0).toDouble(),
        imageUrl: data['imageUrl'],
        checkInDate: data['checkInDate'],
        checkOutDate: data['checkOutDate'],
        guests: data['guests'],
        hotelUid: data['hotelUid'],
        userName: data['userName'],
        userPhone: data['userPhone']
      );
    }).toList();

    emit(BookingLoaded(fetchedBookings)); // ✅ safe update

  } catch (e) {
    emit(BookingError('Failed to cancel booking: $e'));
  }
});



  }

  
}
