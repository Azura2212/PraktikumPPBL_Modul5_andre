import 'package:flutter/material.dart';

class TugasDarurat {
  final String id;
  final String judulKejadian;
  final String kecamatan;
  final String jenisBencana; 
  String status; 
  String catatanVerifikasi;
  bool butuhEvakuasi;

  TugasDarurat({
    required this.id,
    required this.judulKejadian,
    required this.kecamatan,
    required this.jenisBencana,
    this.status = 'Menunggu',
    this.catatanVerifikasi = '-',
    this.butuhEvakuasi = false,
  });
}

class TugasProvider extends ChangeNotifier {
  final List<TugasDarurat> _daftarTugas = [
    TugasDarurat(
      id: 'BPBD-001',
      judulKejadian: 'Genangan Air Luapan DAS Tondano',
      kecamatan: 'Tikala',
      jenisBencana: 'Banjir',
      status: 'Dalam Penanganan',
    ),
    TugasDarurat(
      id: 'BPBD-002',
      judulKejadian: 'Longsor Tebing Pemukiman',
      kecamatan: 'Wanea',
      jenisBencana: 'Tanah Longsor',
      status: 'Menunggu',
    ),
    TugasDarurat(
      id: 'BPBD-003',
      judulKejadian: 'Pohon Tumbang Menutup Akses Jalan',
      kecamatan: 'Malalayang',
      jenisBencana: 'Pohon Tumbang',
      status: 'Selesai',
      catatanVerifikasi: 'Akses jalan sudah dibersihkan tim gabungan.',
    ),
  ];

  List<TugasDarurat> get daftarTugas => _daftarTugas;

  int get jumlahAktif =>
      _daftarTugas.where((t) => t.status != 'Selesai').length;

  int get jumlahSelesai =>
      _daftarTugas.where((t) => t.status == 'Selesai').length;

  // Materi Tombol & Interaksi: Mengubah status penugasan secara langsung
  void ubahStatusTugas(String id, String statusBaru) {
    final index = _daftarTugas.indexWhere((t) => t.id == id);
    if (index != -1) {
      _daftarTugas[index].status = statusBaru;
      notifyListeners();
    }
  }

  // Materi Form & Input: Menambahkan laporan verifikasi baru dari petugas
  void tambahLaporanVerifikasi({
    required String judulKejadian,
    required String kecamatan,
    required String jenisBencana,
    required String status,
    required String catatan,
    required bool butuhEvakuasi,
  }) {
    final newId = 'BPBD-00${_daftarTugas.length + 1}';
    _daftarTugas.insert(
      0,
      TugasDarurat(
        id: newId,
        judulKejadian: judulKejadian,
        kecamatan: kecamatan,
        jenisBencana: jenisBencana,
        status: status,
        catatanVerifikasi: catatan.isEmpty ? 'Terverifikasi petugas' : catatan,
        butuhEvakuasi: butuhEvakuasi,
      ),
    );
    notifyListeners();
  }
}