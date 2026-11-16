
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritCubit extends Cubit<Set<String>> {
  FavoritCubit() : super(<String>{});

  void tandai(String namaLayanan) {
    final Set<String> favoritBaru = Set<String>.from(state);
    favoritBaru.add(namaLayanan);
    emit(favoritBaru);
  }

  void batalTandai(String namaLayanan) {
    final Set<String> favoritBaru = Set<String>.from(state);
    favoritBaru.remove(namaLayanan);
    emit(favoritBaru);
  }

  void toggleFavorit(String namaLayanan) {
    if (state.contains(namaLayanan)) {
      batalTandai(namaLayanan);
    } else {
      tandai(namaLayanan);
    }
  }

  bool isFavorit(String namaLayanan) {
    return state.contains(namaLayanan);
  }
}
