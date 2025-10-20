part of 'favorites_bloc.dart';

sealed class FavoritesEvent {}

class AddToFavorites extends FavoritesEvent {
  final Hotel hotel;

  AddToFavorites(this.hotel);
}

class RemoveFromFavorites extends FavoritesEvent {
   final Hotel hotel;

  RemoveFromFavorites(this.hotel);
}
