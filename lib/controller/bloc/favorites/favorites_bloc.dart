import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cocoon_app/model/hotelmodel.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final List<Hotel> favorites = [];
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  FavoritesBloc() : super(FavoritesInitial()) {
    on<AddToFavorites>(_addToFavorites);
    on<RemoveFromFavorites>(_removeFromFavorites);
    on<LoadFavorites>(_loadFavorites);
  }

  Future<void> _loadFavorites(LoadFavorites event, Emitter<FavoritesState> emit) async {
    final user = auth.currentUser;
    if (user == null) return;

    final snapshot = await firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .get();

    favorites.clear();
    favorites.addAll(
      snapshot.docs.map((doc) => Hotel.fromMap(doc.data(),doc.id)).toList(),
    );

    emit(FavoritesUpdated(List.from(favorites)));
  }

  Future<void> _addToFavorites(AddToFavorites event, Emitter<FavoritesState> emit) async {
    final user = auth.currentUser;
    if (user == null) return;

    if (!favorites.any((hotel) => hotel.id == event.hotel.id)) {
      favorites.add(event.hotel);

      await firestore
          .collection('users')
          .doc(user.uid)
          .collection('favorites')
          .doc(event.hotel.id)
          .set(event.hotel.toMap());

      emit(FavoritesUpdated(List.from(favorites)));
    }
  }

  Future<void> _removeFromFavorites(RemoveFromFavorites event, Emitter<FavoritesState> emit) async {
    final user = auth.currentUser;
    if (user == null) return;

    favorites.removeWhere((hotel) => hotel.id == event.hotel.id);

    await firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites')
        .doc(event.hotel.id)
        .delete();

    emit(FavoritesUpdated(List.from(favorites)));
  }
}
