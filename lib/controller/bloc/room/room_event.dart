import 'package:cocoon_app/model/hotelmodel.dart';
import 'package:cocoon_app/model/room_model.dart';
import 'package:equatable/equatable.dart';

abstract class RoomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchRooms extends RoomEvent {
  final String hotelId;

  FetchRooms(this.hotelId);

  @override
  List<Object?> get props => [hotelId];
}

class SelectRoom extends RoomEvent {
  final Room selectedRoom;
  final Hotel hotel;
  SelectRoom(this.selectedRoom,this.hotel);
}
