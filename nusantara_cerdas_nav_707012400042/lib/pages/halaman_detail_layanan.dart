
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';

class HalamanDetailLayanan extends StatefulWidget {
  final String namaLayanan;

  const HalamanDetailLayanan({
    super.key,
    required this.namaLayanan,
  });

  @override
  State<HalamanDetailLayanan> createState() =>
      _HalamanDetailLayananState();
}

class _HalamanDetailLayananState
    extends State<HalamanDetailLayanan> {
  bool _sedangMemuat = false;

  Future<void> _ajukanPermohonan() async {
    if (_sedangMemuat) {
      return;
    }

    setState(() {
      _sedangMemuat = true;
    });

    // Simulasi proses pengajuan.
    await Future<void>.delayed(
      const Duration(milliseconds: 900),
    );

    if (!mounted) {
      return;
    }

    context
        .read<PengajuanCubit>()
        .tambahPengajuan(widget.namaLayanan);

    const String nilai = 'Pengajuan berhasil dicatat';

    Navigator.pop<String>(context, nilai);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Layanan'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.indigo.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Icon(
              Icons.assignment_outlined,
              size: 64,
              color: Colors.indigo,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            widget.namaLayanan,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Halaman ini memberikan informasi layanan kota '
            'yang dapat diajukan oleh warga melalui aplikasi '
            'Nusantara Cerdas Mobile.',
            style: TextStyle(height: 1.6),
          ),
          const SizedBox(height: 24),
          const Text(
            'Informasi Pengajuan',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.check_circle_outline),
            title: Text('Pilih layanan yang dibutuhkan'),
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.send_outlined),
            title: Text('Kirim permohonan melalui aplikasi'),
          ),
          const ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.assignment_turned_in_outlined),
            title: Text('Pengajuan tercatat dalam daftar warga'),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed:
                  _sedangMemuat ? null : _ajukanPermohonan,
              icon: _sedangMemuat
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    )
                  : const Icon(Icons.send),
              label: Text(
                _sedangMemuat
                    ? 'Mengirim Pengajuan...'
                    : 'Ajukan Permohonan',
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
