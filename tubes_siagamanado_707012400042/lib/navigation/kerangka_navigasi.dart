import 'package:flutter/material.dart';
import 'app_routes.dart';
import '../pages/dashboard_petugas_page.dart';
import '../pages/form_verifikasi_page.dart';
import '../pages/statistik_bencana_page.dart';

class KerangkaNavigasi {
  static Map<String, WidgetBuilder> get routes => {
        AppRoutes.dashboard: (context) => const DashboardPetugasPage(),
        AppRoutes.formVerifikasi: (context) => const FormVerifikasiPage(),
        AppRoutes.statistik: (context) => const StatistikBencanaPage(),
      };

  static void keFormVerifikasi(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.formVerifikasi);
  }

  static void keStatistik(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.statistik);
  }
}