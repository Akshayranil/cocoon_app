import 'package:bloc/bloc.dart';
import 'package:cocoon_app/model/hotelmodel.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final List<Hotel> favorites = [];
  FavoritesBloc() : super(FavoritesInitial()) {
    on<AddToFavorites>((event, emit) {
      if (!favorites.contains(event.hotel)) {
        favorites.add(event.hotel);
        emit(FavoritesUpdated(List.from(favorites)));
      }
    });

    on<RemoveFromFavorites>((event, emit) {
      favorites.remove(event.hotel);
      emit(FavoritesUpdated(List.from(favorites)));
    });
  }
}
