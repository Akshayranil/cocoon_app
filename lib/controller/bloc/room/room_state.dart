import 'package:cocoon_app/model/room_model.dart';
import 'package:equatable/equatable.dart';


abstract class RoomState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class RoomLoaded extends RoomState {
  final List<Room> rooms;
  RoomLoaded(this.rooms);

  @override
  List<Object?> get props => [rooms];
}

class RoomError extends RoomState {
  final String message;
  RoomError(this.message);

  @override
  List<Object?> get props => [message];
}

class RoomSelected extends RoomState {
  final Room room;
  RoomSelected(this.room);
}

