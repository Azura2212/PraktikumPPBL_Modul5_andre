
import 'package:flutter_bloc/flutter_bloc.dart';

class PengajuanCubit extends Cubit<List<String>> {
  PengajuanCubit() : super(<String>[]);

  int get totalPengajuan => state.length;

  void tambahPengajuan(String namaLayanan) {
    final List<String> pengajuanBaru = List<String>.from(state);
    pengajuanBaru.add(namaLayanan);
    emit(pengajuanBaru);
  }

  void hapusPengajuan(int index) {
    if (index < 0 || index >= state.length) {
      return;
    }

    final List<String> pengajuanBaru = List<String>.from(state);
    pengajuanBaru.removeAt(index);
    emit(pengajuanBaru);
  }

  void kosongkanPengajuan() {
    emit(<String>[]);
  }
}
