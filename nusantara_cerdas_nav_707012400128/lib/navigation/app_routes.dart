
import 'package:flutter/material.dart';

import '../pages/halaman_detail_layanan.dart';
import '../pages/halaman_pengaturan_kota.dart';
import '../pages/halaman_tentang_aplikasi.dart';
import '../pages/halaman_tidak_ditemukan.dart';

class AppRoutes {
  static const String beranda = '/';
  static const String detail = '/detail';
  static const String pengaturan = '/pengaturan';
  static const String tentang = '/tentang';
  static const String tidakDitemukan = '/salah';

  static Route<dynamic> generateRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {
      case detail:
        final Object? argument = settings.arguments;

        if (argument is String && argument.isNotEmpty) {
          return MaterialPageRoute<String>(
            settings: settings,
            builder: (_) => HalamanDetailLayanan(
              namaLayanan: argument,
            ),
          );
        }

        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const HalamanTidakDitemukan(),
        );

      case pengaturan:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const HalamanPengaturanKota(),
        );

      case tentang:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const HalamanTentangAplikasi(),
        );

      case tidakDitemukan:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const HalamanTidakDitemukan(),
        );

      default:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const HalamanTidakDitemukan(),
        );
    }
  }
}
