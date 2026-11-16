
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';
import 'app_routes.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() =>
      _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  final List<String> _judulHalaman = const [
    'Beranda',
    'Layanan',
    'Warga',
  ];

  void _pilihHalaman(int indeks) {
    setState(() {
      _indeksTerpilih = indeks;
    });
  }

  Future<void> _bukaHalamanTambahan(String route) async {
    Navigator.pop(context);

    await Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final bool layarLebar = constraints.maxWidth >= 600;

        return Scaffold(
          appBar: AppBar(
            title: Text(_judulHalaman[_indeksTerpilih]),
            leading: layarLebar
                ? null
                : Builder(
                    builder: (context) {
                      return IconButton(
                        tooltip: 'Buka menu',
                        icon: const Icon(Icons.menu),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      );
                    },
                  ),
            actions: [
              IconButton(
                tooltip: 'Pengaturan kota',
                icon: const Icon(Icons.settings_outlined),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutes.pengaturan,
                  );
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          drawer: layarLebar
              ? null
              : _buatDrawer(context),
          body: Row(
            children: [
              if (layarLebar)
                NavigationRail(
                  selectedIndex: _indeksTerpilih,
                  onDestinationSelected: _pilihHalaman,
                  labelType: NavigationRailLabelType.all,
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 20,
                    ),
                    child: Icon(
                      Icons.location_city,
                      size: 32,
                      color: Colors.indigo,
                    ),
                  ),
                  destinations: [
                    const NavigationRailDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: Text('Beranda'),
                    ),
                    const NavigationRailDestination(
                      icon: Icon(Icons.apps_outlined),
                      selectedIcon: Icon(Icons.apps),
                      label: Text('Layanan'),
                    ),
                    NavigationRailDestination(
                      icon: const IkonWargaDenganBadge(),
                      selectedIcon: const IkonWargaDenganBadge(
                        terpilih: true,
                      ),
                      label: const Text('Warga'),
                    ),
                  ],
                ),
              if (layarLebar)
                const VerticalDivider(
                  width: 1,
                  thickness: 1,
                ),
              Expanded(
                child: IndexedStack(
                  index: _indeksTerpilih,
                  children: _halaman,
                ),
              ),
            ],
          ),
          bottomNavigationBar: layarLebar
              ? null
              : NavigationBar(
                  selectedIndex: _indeksTerpilih,
                  onDestinationSelected: _pilihHalaman,
                  destinations: [
                    const NavigationDestination(
                      icon: Icon(Icons.home_outlined),
                      selectedIcon: Icon(Icons.home),
                      label: 'Beranda',
                    ),
                    const NavigationDestination(
                      icon: Icon(Icons.apps_outlined),
                      selectedIcon: Icon(Icons.apps),
                      label: 'Layanan',
                    ),
                    const NavigationDestination(
                      icon: IkonWargaDenganBadge(),
                      selectedIcon: IkonWargaDenganBadge(
                        terpilih: true,
                      ),
                      label: 'Warga',
                    ),
                  ],
                ),
        );
      },
    );
  }

  Widget _buatDrawer(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: null,
      onDestinationSelected: (indeks) {
        if (indeks == 0) {
          _bukaHalamanTambahan(AppRoutes.pengaturan);
        } else if (indeks == 1) {
          _bukaHalamanTambahan(AppRoutes.tentang);
        }
      },
      children: const [
        Padding(
          padding: EdgeInsets.fromLTRB(24, 24, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_city,
                size: 42,
                color: Colors.indigo,
              ),
              SizedBox(height: 12),
              Text(
                'Nusantara Cerdas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text('Layanan kota dalam satu aplikasi'),
            ],
          ),
        ),
        Divider(),
        NavigationDrawerDestination(
          icon: Icon(Icons.settings_outlined),
          label: Text('Pengaturan Kota'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.info_outline),
          label: Text('Tentang Aplikasi'),
        ),
      ],
    );
  }
}

class IkonWargaDenganBadge extends StatelessWidget {
  final bool terpilih;

  const IkonWargaDenganBadge({
    super.key,
    this.terpilih = false,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<PengajuanCubit, List<String>, int>(
      selector: (daftarPengajuan) => daftarPengajuan.length,
      builder: (context, total) {
        return Badge(
          isLabelVisible: total > 0,
          label: Text('$total'),
          child: Icon(
            terpilih
                ? Icons.people
                : Icons.people_outline,
          ),
        );
      },
    );
  }
}
