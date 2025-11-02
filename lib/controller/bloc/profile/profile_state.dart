part of 'profile_bloc.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoadingState extends ProfileState {}

final class ProfileSavedState extends ProfileState {}

final class ProfileErrorState extends ProfileState {
  final String error;

  ProfileErrorState(this.error);
}

class ProfileImagePickedState extends ProfileState {
  final File image;
  ProfileImagePickedState(this.image);
}

class ProfileLoadedState extends ProfileState {
  final Map<String, dynamic> userData;
  ProfileLoadedState(this.userData);
}

