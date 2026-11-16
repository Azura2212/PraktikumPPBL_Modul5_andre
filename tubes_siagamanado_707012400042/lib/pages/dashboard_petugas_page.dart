import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/tugas_provider.dart';
import '../model/laporan_chart_provider.dart';
import '../navigation/kerangka_navigasi.dart';

class DashboardPetugasPage extends StatelessWidget {
  const DashboardPetugasPage({super.key});

  Color _warnaStatus(String status) {
    switch (status) {
      case 'Selesai':
        return Colors.greenAccent.shade700;
      case 'Dalam Penanganan':
        return Colors.orangeAccent.shade700;
      default:
        return Colors.redAccent;
    }
  }

  String _statusBerikutnya(String statusSaatIni) {
    if (statusSaatIni == 'Menunggu') return 'Dalam Penanganan';
    if (statusSaatIni == 'Dalam Penanganan') return 'Selesai';
    return 'Menunggu';
  }

  @override
  Widget build(BuildContext context) {
    final tugasProv = context.watch<TugasProvider>();
    final chartProv = context.watch<LaporanChartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Siaga Manado — Petugas BPBD'),
        actions: [
          IconButton(
            tooltip: 'Lihat Statistik Bencana',
            icon: const Icon(Icons.bar_chart_rounded),
            onPressed: () => KerangkaNavigasi.keStatistik(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kartu Ringkasan Lintas Provider
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF551313),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _infoItem('Tugas Aktif', '${tugasProv.jumlahAktif}'),
                  _infoItem('Selesai', '${tugasProv.jumlahSelesai}'),
                  _infoItem('Total Insiden', '${chartProv.totalKejadian}'),
                ],
              ),
            ),
            const SizedBox(height: 12),

            // ElevatedButton ke Halaman Statistik
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade900,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                icon: const Icon(Icons.analytics_outlined),
                label: const Text('Buka Grafik Statistik Bencana Manado'),
                onPressed: () => KerangkaNavigasi.keStatistik(context),
              ),
            ),
            const SizedBox(height: 16),

            const Text(
              'Daftar Penugasan Lapangan (Ketuk badge status untuk ubah)',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
            const SizedBox(height: 8),

            // Daftar Tugas
            Expanded(
              child: ListView.builder(
                itemCount: tugasProv.daftarTugas.length,
                itemBuilder: (context, index) {
                  final tugas = tugasProv.daftarTugas[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${tugas.id} • Kec. ${tugas.kecamatan}',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                              // GestureDetector untuk interaksi cepat ubah status
                              GestureDetector(
                                onTap: () {
                                  final next = _statusBerikutnya(tugas.status);
                                  context
                                      .read<TugasProvider>()
                                      .ubahStatusTugas(tugas.id, next);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Status ${tugas.id} diubah menjadi "$next"',
                                      ),
                                      duration: const Duration(seconds: 1),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _warnaStatus(tugas.status),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        tugas.status,
                                        style: const TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.touch_app,
                                        size: 13,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(
                            tugas.judulKejadian,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Kategori: ${tugas.jenisBencana} | Evakuasi: ${tugas.butuhEvakuasi ? "Ya" : "Tidak"}',
                            style: const TextStyle(fontSize: 12),
                          ),
                          if (tugas.catatanVerifikasi != '-') ...[
                            const SizedBox(height: 4),
                            Text(
                              'Catatan: ${tugas.catatanVerifikasi}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade300,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF551313),
        foregroundColor: Colors.white,
        onPressed: () => KerangkaNavigasi.keFormVerifikasi(context),
        icon: const Icon(Icons.add_task),
        label: const Text('Verifikasi Baru'),
      ),
    );
  }

  Widget _infoItem(String label, String nilai) {
    return Column(
      children: [
        Text(
          nilai,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}