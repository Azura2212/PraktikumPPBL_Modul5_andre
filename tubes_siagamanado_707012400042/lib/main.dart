import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/tugas_provider.dart';
import 'model/laporan_chart_provider.dart';
import 'navigation/app_routes.dart';
import 'navigation/kerangka_navigasi.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TugasProvider()),
        ChangeNotifierProvider(create: (_) => LaporanChartProvider()),
      ],
      child: const SiagaManadoApp(),
    ),
  );
}

class SiagaManadoApp extends StatelessWidget {
  const SiagaManadoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siaga Manado - BPBD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF000000),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF551313),
          foregroundColor: Colors.white,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF551313),
          secondary: Colors.redAccent,
        ),
      ),
      initialRoute: AppRoutes.dashboard,
      routes: KerangkaNavigasi.routes,
    );
  }
}