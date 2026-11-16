import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/tugas_provider.dart';
import '../model/laporan_chart_provider.dart';

class FormVerifikasiPage extends StatefulWidget {
  const FormVerifikasiPage({super.key});

  @override
  State<FormVerifikasiPage> createState() => _FormVerifikasiPageState();
}

class _FormVerifikasiPageState extends State<FormVerifikasiPage> {
  final _judulController = TextEditingController();
  final _kecamatanController = TextEditingController();
  final _catatanController = TextEditingController();

  String _jenisBencana = 'Banjir';
  String _statusPenanganan = 'Dalam Penanganan';
  bool _butuhEvakuasi = false;
  bool _dataValid = false;

  @override
  void dispose() {
    _judulController.dispose();
    _kecamatanController.dispose();
    _catatanController.dispose();
    super.dispose();
  }

  void _simpanLaporan() {
    if (_judulController.text.trim().isEmpty ||
        _kecamatanController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Judul kejadian dan kecamatan wajib diisi!')),
      );
      return;
    }

    if (!_dataValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Centang pernyataan validasi petugas lapangan terlebih dahulu.'),
        ),
      );
      return;
    }

    // Update TugasProvider
    context.read<TugasProvider>().tambahLaporanVerifikasi(
          judulKejadian: _judulController.text.trim(),
          kecamatan: _kecamatanController.text.trim(),
          jenisBencana: _jenisBencana,
          status: _statusPenanganan,
          catatan: _catatanController.text.trim(),
          butuhEvakuasi: _butuhEvakuasi,
        );

    // Update LaporanChartProvider agar chart ikut bertambah real-time
    context
        .read<LaporanChartProvider>()
        .tambahStatistikBencana(_jenisBencana);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Form Verifikasi Lapangan')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TextField 1
            TextField(
              controller: _judulController,
              decoration: const InputDecoration(
                labelText: 'Judul Kejadian Darurat',
                hintText: 'Contoh: Banjir Bandang Malalayang',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),

            // TextField 2
            TextField(
              controller: _kecamatanController,
              decoration: const InputDecoration(
                labelText: 'Kecamatan di Kota Manado',
                hintText: 'Contoh: Sario / Wenang / Tuminting',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // RadioListTile untuk Jenis Bencana
            const Text(
              'Kategori Bencana:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Banjir'),
              value: 'Banjir',
              groupValue: _jenisBencana,
              onChanged: (val) => setState(() => _jenisBencana = val!),
            ),
            RadioListTile<String>(
              title: const Text('Tanah Longsor'),
              value: 'Tanah Longsor',
              groupValue: _jenisBencana,
              onChanged: (val) => setState(() => _jenisBencana = val!),
            ),
            RadioListTile<String>(
              title: const Text('Pohon Tumbang'),
              value: 'Pohon Tumbang',
              groupValue: _jenisBencana,
              onChanged: (val) => setState(() => _jenisBencana = val!),
            ),

            const Divider(),

            // RadioListTile untuk Status
            const Text(
              'Status Penanganan Saat Ini:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: const Text('Dalam Penanganan'),
              value: 'Dalam Penanganan',
              groupValue: _statusPenanganan,
              onChanged: (val) => setState(() => _statusPenanganan = val!),
            ),
            RadioListTile<String>(
              title: const Text('Selesai'),
              value: 'Selesai',
              groupValue: _statusPenanganan,
              onChanged: (val) => setState(() => _statusPenanganan = val!),
            ),

            const Divider(),

            // CheckboxListTile
            CheckboxListTile(
              title: const Text('Membutuhkan Tim Evakuasi & Perahu Karet'),
              value: _butuhEvakuasi,
              onChanged: (val) => setState(() => _butuhEvakuasi = val ?? false),
            ),
            CheckboxListTile(
              title: const Text(
                'Saya menyatakan kondisi lapangan benar & terverifikasi',
              ),
              value: _dataValid,
              onChanged: (val) => setState(() => _dataValid = val ?? false),
            ),

            const SizedBox(height: 12),

            // TextField 3
            TextField(
              controller: _catatanController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Catatan Tambahan Petugas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF551313),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.send),
                label: const Text('Kirim Laporan Verifikasi'),
                onPressed: _simpanLaporan,
              ),
            ),
          ],
        ),
      ),
    );
  }
}