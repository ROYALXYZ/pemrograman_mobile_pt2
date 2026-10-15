import 'package:flutter/material.dart';

/// Halaman "Tentang Aplikasi" yang disusun dengan [Stack].
///
/// Latar berupa gradien, teks judul berada di tengah, dan tombol "Kembali"
/// diposisikan di pojok kiri atas memakai [Positioned].
class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // Semua anak yang tidak memakai Positioned otomatis diletakkan di
        // tengah Stack, karena itu kita tidak perlu membungkus teks dengan
        // widget Center.
        alignment: Alignment.center,
        children: [
          // 1. Latar: Container + BoxDecoration dengan gradien.
          // Positioned.fill dipakai agar latar menutupi seluruh layar. Tanpa
          // itu, Container hanya sekecil isinya dan gradien tidak terlihat.
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF1565C0),
                    const Color(0xFF6A1B9A),
                  ],
                ),
              ),
            ),
          ),

          // 2. Tombol "Kembali" di pojok kiri atas.
          // SafeArea mencegah tombol tertutup status bar / notch.
          Positioned(
            top: 8,
            left: 8,
            child: SafeArea(child: _buildBackButton(context)),
          ),

          // 3. Konten di tengah.
          _buildKonten(),
        ],
      ),
    );
  }

  /// Tombol kembali berbentuk lingkaran transparan agar kontras di atas gradien.
  ///
  /// [Navigator.pop] menutup halaman ini dan otomatis kembali ke halaman
  /// sebelumnya, tanpa perlu tahu halaman asalnya apa.
  Widget _buildBackButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        tooltip: 'Kembali',
        icon: const Icon(Icons.arrow_back),
        color: Colors.white,
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  /// Isi halaman: ikon, judul, deskripsi, dan nomor versi.
  Widget _buildKonten() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        // mainAxisSize.min membuat Column hanya setinggi isinya, bukan
        // setinggi layar, supaya benar-benar berada di tengah.
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.school, size: 72, color: Colors.white),
          const SizedBox(height: 24),
          const Text(
            'Tentang Aplikasi',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Aplikasi Profil Mahasiswa untuk Submission Praktikum '
            'Pemrograman Mobile Pertemuan 2, showcasing widget dasar dan '
            'layout Flutter.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Versi 1.0.0',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
