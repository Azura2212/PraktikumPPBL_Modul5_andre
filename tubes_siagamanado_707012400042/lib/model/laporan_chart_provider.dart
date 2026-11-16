import 'package:flutter/material.dart';

class LaporanChartProvider extends ChangeNotifier {
  final Map<String, int> _dataKejadian = {
    'Banjir': 8,
    'Tanah Longsor': 5,
    'Pohon Tumbang': 6,
  };

  Map<String, int> get dataKejadian => _dataKejadian;

  int get totalKejadian =>
      _dataKejadian.values.fold(0, (sum, item) => sum + item);

  void tambahStatistikBencana(String kategori) {
    if (_dataKejadian.containsKey(kategori)) {
      _dataKejadian[kategori] = _dataKejadian[kategori]! + 1;
    } else {
      _dataKejadian[kategori] = 1;
    }
    notifyListeners();
  }
}