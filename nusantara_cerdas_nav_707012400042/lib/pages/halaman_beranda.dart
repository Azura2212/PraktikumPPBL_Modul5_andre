
import 'package:flutter/material.dart';

class HalamanBeranda extends StatelessWidget {
  const HalamanBeranda({super.key});

  static const List<Map<String, dynamic>> _pilar = [
    {
      'nama': 'Smart Governance',
      'deskripsi': 'Pemerintahan yang transparan dan responsif.',
      'ikon': Icons.account_balance_outlined,
      'warna': Colors.indigo,
    },
    {
      'nama': 'Smart Branding',
      'deskripsi': 'Membangun identitas dan daya tarik kota.',
      'ikon': Icons.travel_explore,
      'warna': Colors.deepOrange,
    },
    {
      'nama': 'Smart Economy',
      'deskripsi': 'Mendukung ekonomi dan inovasi digital.',
      'ikon': Icons.trending_up,
      'warna': Colors.green,
    },
    {
      'nama': 'Smart Living',
      'deskripsi': 'Meningkatkan kualitas hidup masyarakat.',
      'ikon': Icons.health_and_safety_outlined,
      'warna': Colors.teal,
    },
    {
      'nama': 'Smart Society',
      'deskripsi': 'Mendorong masyarakat yang inklusif.',
      'ikon': Icons.groups_outlined,
      'warna': Colors.purple,
    },
    {
      'nama': 'Smart Environment',
      'deskripsi': 'Menjaga lingkungan melalui teknologi.',
      'ikon': Icons.eco_outlined,
      'warna': Colors.lightGreen,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF0F766E),
                    Color(0xFF34A58E),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_city_rounded,
                    color: Colors.white,
                    size: 42,
                  ),
                  SizedBox(height: 18),
                  Text(
                    'Nusantara Cerdas',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Kenali layanan kota dan ajukan kebutuhanmu '
                    'melalui satu aplikasi.',
                    style: TextStyle(
                      color: Colors.white,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Enam Pilar Kota Cerdas',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            LayoutBuilder(
              builder: (context, constraints) {
                final int jumlahKolom =
                    constraints.maxWidth >= 850
                        ? 3
                        : constraints.maxWidth >= 500
                            ? 2
                            : 1;

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _pilar.length,
                  gridDelegate:
                      SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: jumlahKolom,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 145,
                  ),
                  itemBuilder: (context, index) {
                    final pilar = _pilar[index];

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment:
                              CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: (pilar['warna'] as Color)
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              child: Icon(
                                pilar['ikon'] as IconData,
                                color: pilar['warna'] as Color,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              pilar['nama'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: Text(
                                pilar['deskripsi'] as String,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
