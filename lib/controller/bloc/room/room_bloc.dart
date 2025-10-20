// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:cocoon_app/controller/bloc/room/room_event.dart';
// import 'package:cocoon_app/controller/bloc/room/room_state.dart';
// import 'package:cocoon_app/model/room_model.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';


// class RoomBloc extends Bloc<RoomEvent, RoomState> {
//   RoomBloc() : super(RoomInitial()) {
//     on<FetchRooms>((event, emit) async {
//       emit(RoomLoading());
//       try {
//         final querySnapshot = await FirebaseFirestore.instance
//             .collection('hotelregistration')
//             .doc(event.hotelId)
//             .collection('rooms')
//             .get();

//         final rooms = querySnapshot.docs
//             .map((doc) => Room.fromMap(doc.data(), doc.id))
//             .toList();

//         emit(RoomLoaded(rooms));
//       } catch (e) {
//         emit(RoomError('Failed to load rooms: $e'));
//       }
//     });
//     on<SelectRoom>((event, emit) {
//   emit(RoomSelected(event.selectedRoom));
// });

//   }
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cocoon_app/controller/bloc/room/room_event.dart';
import 'package:cocoon_app/controller/bloc/room/room_state.dart';
import 'package:cocoon_app/model/room_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc() : super(RoomInitial()) {
    on<FetchRooms>((event, emit) async {
      emit(RoomLoading());

      try {
        final firestore = FirebaseFirestore.instance;

        // 🔹 Step 1: Fetch all amenities
        final amenitiesSnapshot = await firestore.collection('aminities').get();

        // 🔹 Step 2: Create a map of {id: name}
        final Map<String, String> amenityMap = {
          for (var doc in amenitiesSnapshot.docs)
            doc.id: doc['name'] ?? '',
        };

        // 🔹 Step 3: Fetch all rooms for the hotel
        final roomsSnapshot = await firestore
            .collection('hotelregistration')
            .doc(event.hotelId)
            .collection('rooms')
            .get();

        // 🔹 Step 4: Convert room data & replace IDs with names
        final rooms = roomsSnapshot.docs.map((doc) {
          final data = doc.data();

          // Convert amenities IDs to names
          final List<String> ids = List<String>.from(data['aminities'] ?? []);
          final List<String> names =
              ids.map((id) => amenityMap[id] ?? id).toList();

          // Replace in map
          final updatedData = {
            ...data,
            'aminities': names,
          };

          return Room.fromMap(updatedData, doc.id);
        }).toList();

        emit(RoomLoaded(rooms));
      } catch (e) {
        emit(RoomError('Failed to load rooms: $e'));
      }
    });

    on<SelectRoom>((event, emit) {
      emit(RoomSelected(event.selectedRoom));
    });
  }
}

