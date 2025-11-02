part of 'profile_bloc.dart';

sealed class ProfileEvent {}

class SaveProfileEvent extends ProfileEvent {
  final String name;
  final String phone;
  final String image;

  SaveProfileEvent(this.name, this.phone,this.image);
}




class PickImageEvent extends ProfileEvent {
  final File image;
  PickImageEvent(this.image);
}

class FetchProfileEvent extends ProfileEvent {
  final String uid;
  FetchProfileEvent(this.uid);
}

