
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/favorit_cubit.dart';
import '../cubit/pengajuan_cubit.dart';
import '../navigation/app_routes.dart';

class HalamanWarga extends StatelessWidget {
  const HalamanWarga({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            'Ruang Warga',
            style: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Kelola layanan favorit dan pantau pengajuanmu.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 24),
          _bagianFavorit(context),
          const SizedBox(height: 24),
          _bagianPengajuan(context),
        ],
      ),
    );
  }

  Widget _bagianFavorit(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 8),
                Text(
                  'Layanan Favorit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            BlocBuilder<FavoritCubit, Set<String>>(
              builder: (context, daftarFavorit) {
                if (daftarFavorit.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Belum ada layanan favorit. '
                      'Buka menu Layanan dan tekan ikon bintang.',
                    ),
                  );
                }

                return Column(
                  children: daftarFavorit.map((namaLayanan) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      title: Text(namaLayanan),
                      trailing: IconButton(
                        tooltip: 'Hapus favorit',
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          context
                              .read<FavoritCubit>()
                              .batalTandai(namaLayanan);
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _bagianPengajuan(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(
                  Icons.assignment_outlined,
                  color: Colors.indigo,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Pengajuan Layanan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            BlocBuilder<PengajuanCubit, List<String>>(
              builder: (context, daftarPengajuan) {
                if (daftarPengajuan.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      'Belum ada pengajuan layanan.',
                    ),
                  );
                }

                return Column(
                  children: [
                    for (int index = 0;
                        index < daftarPengajuan.length;
                        index++)
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: CircleAvatar(
                          child: Text('${index + 1}'),
                        ),
                        title: Text(daftarPengajuan[index]),
                        subtitle: const Text('Pengajuan tercatat'),
                        trailing: IconButton(
                          tooltip: 'Hapus pengajuan',
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            context
                                .read<PengajuanCubit>()
                                .hapusPengajuan(index);
                          },
                        ),
                      ),
                  ],
                );
              },
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.pengaturan,
                  );
                },
                icon: const Icon(Icons.settings_outlined),
                label: const Text('Buka Pengaturan Kota'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
