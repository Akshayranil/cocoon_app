part of 'favorites_bloc.dart';

sealed class FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesUpdated extends FavoritesState {
  final List<Hotel> favoriteHotels;

  FavoritesUpdated(this.favoriteHotels);
}
