
import 'package:flutter/material.dart';

class HalamanPengaturanKota extends StatefulWidget {
  const HalamanPengaturanKota({super.key});

  @override
  State<HalamanPengaturanKota> createState() =>
      _HalamanPengaturanKotaState();
}

class _HalamanPengaturanKotaState
    extends State<HalamanPengaturanKota> {
  bool _notifikasiAktif = true;
  bool _lokasiAktif = true;
  String _pilihanKota = 'Bandung';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan Kota'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Preferensi Aplikasi',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: DropdownButtonFormField<String>(
                initialValue: _pilihanKota,
                decoration: const InputDecoration(
                  labelText: 'Kota pilihan',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.location_city),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Bandung',
                    child: Text('Bandung'),
                  ),
                  DropdownMenuItem(
                    value: 'Sumedang',
                    child: Text('Sumedang'),
                  ),
                  DropdownMenuItem(
                    value: 'Jakarta',
                    child: Text('Jakarta'),
                  ),
                ],
                onChanged: (nilai) {
                  if (nilai == null) {
                    return;
                  }

                  setState(() {
                    _pilihanKota = nilai;
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Notifikasi'),
                  subtitle: const Text(
                    'Aktifkan pemberitahuan aplikasi.',
                  ),
                  secondary: const Icon(
                    Icons.notifications_outlined,
                  ),
                  value: _notifikasiAktif,
                  onChanged: (nilai) {
                    setState(() {
                      _notifikasiAktif = nilai;
                    });
                  },
                ),
                const Divider(height: 1),
                SwitchListTile(
                  title: const Text('Akses Lokasi'),
                  subtitle: const Text(
                    'Preferensi penggunaan lokasi untuk layanan kota.',
                  ),
                  secondary: const Icon(
                    Icons.location_on_outlined,
                  ),
                  value: _lokasiAktif,
                  onChanged: (nilai) {
                    setState(() {
                      _lokasiAktif = nilai;
                    });
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Pengaturan untuk $_pilihanKota diterapkan '
                    'pada tampilan saat ini.',
                  ),
                ),
              );
            },
            child: const Text('Terapkan Pengaturan'),
          ),
        ],
      ),
    );
  }
}
