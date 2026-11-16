
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../navigation/app_routes.dart';

class HalamanLayanan extends StatelessWidget {
  const HalamanLayanan({super.key});

  static const Map<String, List<String>> _daftarLayanan = {
    'Perizinan': [
      'Pengajuan KTP',
      'Surat Keterangan Domisili',
      'Perizinan Usaha',
    ],
    'Kesehatan': [
      'Informasi Puskesmas',
      'Pendaftaran Layanan Kesehatan',
      'Informasi Posyandu',
    ],
    'Transportasi': [
      'Informasi Angkutan Umum',
      'Laporan Jalan Rusak',
      'Informasi Lalu Lintas',
    ],
  };

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _daftarLayanan.length,
      child: Scaffold(
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 16, 20, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Temukan Layanan Kota',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text('Pilih kategori untuk melihat layanan yang tersedia.'),
                ],
              ),
            ),
            const TabBar(
              isScrollable: true,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: [
                Tab(
                  icon: Icon(Icons.description_outlined),
                  text: 'Perizinan',
                ),
                Tab(
                  icon: Icon(Icons.health_and_safety_outlined),
                  text: 'Kesehatan',
                ),
                Tab(
                  icon: Icon(Icons.directions_bus_outlined),
                  text: 'Transportasi',
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: _daftarLayanan.entries.map((entry) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: entry.value.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final String namaLayanan =
                          entry.value[index];

                      return _KartuLayanan(
                        namaLayanan: namaLayanan,
                        kategori: entry.key,
                      );
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _KartuLayanan extends StatelessWidget {
  final String namaLayanan;
  final String kategori;

  const _KartuLayanan({
    required this.namaLayanan,
    required this.kategori,
  });

  IconData get _ikonKategori {
    switch (kategori) {
      case 'Perizinan':
        return Icons.description_outlined;
      case 'Kesehatan':
        return Icons.health_and_safety_outlined;
      default:
        return Icons.directions_bus_outlined;
    }
  }

  Future<void> _bukaDetail(BuildContext context) async {
    final String? hasil = await Navigator.pushNamed<String>(
      context,
      AppRoutes.detail,
      arguments: namaLayanan,
    );

    if (!context.mounted || hasil == null) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Hasil dari halaman detail: $hasil'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final warnaUtama = Theme.of(context).colorScheme.primary;

    return Card(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: warnaUtama.withValues(alpha: 0.1),
          child: Icon(
            _ikonKategori,
            color: warnaUtama,
          ),
        ),
        title: Text(
          namaLayanan,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(kategori),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<FavoritCubit, Set<String>>(
              builder: (context, daftarFavorit) {
                final bool sudahFavorit =
                    daftarFavorit.contains(namaLayanan);

                return IconButton(
                  tooltip: sudahFavorit
                      ? 'Hapus dari favorit'
                      : 'Tambahkan ke favorit',
                  icon: Icon(
                    sudahFavorit
                        ? Icons.star
                        : Icons.star_border,
                    color: sudahFavorit
                        ? Colors.amber.shade700
                        : Colors.grey,
                  ),
                  onPressed: () {
                    context
                        .read<FavoritCubit>()
                        .toggleFavorit(namaLayanan);
                  },
                );
              },
            ),
            Icon(Icons.chevron_right, color: Colors.grey.shade500),
          ],
        ),
        onTap: () => _bukaDetail(context),
      ),
    );
  }
}
