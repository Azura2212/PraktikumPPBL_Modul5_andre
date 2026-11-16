import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/laporan_chart_provider.dart';
import '../model/tugas_provider.dart';

class StatistikBencanaPage extends StatelessWidget {
  const StatistikBencanaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final chartProv = context.watch<LaporanChartProvider>();
    final tugasProv = context.watch<TugasProvider>();

    final banjir = chartProv.dataKejadian['Banjir'] ?? 0;
    final longsor = chartProv.dataKejadian['Tanah Longsor'] ?? 0;
    final pohon = chartProv.dataKejadian['Pohon Tumbang'] ?? 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Statistik Insiden Manado')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Distribusi Kejadian Bencana Kota Manado',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Total tercatat: ${chartProv.totalKejadian} insiden (${tugasProv.jumlahAktif} tugas aktif)',
              style: TextStyle(color: Colors.grey.shade400),
            ),
            const SizedBox(height: 24),

            SizedBox(
              height: 260,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: ( [banjir, longsor, pohon].reduce((a, b) => a > b ? a : b) + 4 )
                      .toDouble(),
                  barTouchData: BarTouchData(enabled: true),
                  titlesData: FlTitlesData(
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Text('Banjir', style: TextStyle(fontSize: 12)),
                              );
                            case 1:
                              return const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Text('Longsor', style: TextStyle(fontSize: 12)),
                              );
                            case 2:
                              return const Padding(
                                padding: EdgeInsets.only(top: 6),
                                child: Text('Pohon', style: TextStyle(fontSize: 12)),
                              );
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  barGroups: [
                    _buatBatang(0, banjir.toDouble(), Colors.blueAccent),
                    _buatBatang(1, longsor.toDouble(), Colors.orangeAccent),
                    _buatBatang(2, pohon.toDouble(), Colors.tealAccent),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Rincian Data Real-Time:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text('• Banjir: $banjir kejadian'),
                    Text('• Tanah Longsor: $longsor kejadian'),
                    Text('• Pohon Tumbang: $pohon kejadian'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buatBatang(int x, double y, Color warna) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: warna,
          width: 28,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        ),
      ],
    );
  }
}