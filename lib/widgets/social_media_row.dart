import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Baris deretan tombol media sosial (Instagram, LinkedIn, GitHub).
///
/// Ikon diambil dari [FontAwesomeIcons] agar tampil sebagai logo asli masing-masing
/// platform, bukan ikon generik Material. Widget ini tetap [StatelessWidget]
/// karena hanya menampilkan umpan balik lewat [ScaffoldMessenger] tanpa
/// mengubah state apa pun.
class SocialMediaRow extends StatelessWidget {
  const SocialMediaRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialButton(
          context,
          icon: FontAwesomeIcons.instagram,
          warna: const Color(0xFFE4405F),
          nama: 'Instagram',
        ),
        _buildSocialButton(
          context,
          icon: FontAwesomeIcons.linkedin,
          warna: const Color(0xFF0A66C2),
          nama: 'LinkedIn',
        ),
        _buildSocialButton(
          context,
          icon: FontAwesomeIcons.github,
          warna: const Color(0xFF24292F),
          nama: 'GitHub',
        ),
      ],
    );
  }

  /// Membangun satu tombol bulat untuk sebuah platform media sosial.
  ///
  /// Parameter [nama] dipakai sebagai teks [SnackBar] agar pengguna tahu
  /// tombol mana yang baru saja diklik.
  Widget _buildSocialButton(
    BuildContext context, {
    required FaIconData icon,
    required Color warna,
    required String nama,
  }) {
    return IconButton(
      tooltip: nama,
      iconSize: 28,
      onPressed: () {
        ScaffoldMessenger.of(context)
          // Hilangkan snackbar sebelumnya agar tidak menumpuk saat diklik cepat.
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text('Membuka profil $nama'),
              duration: const Duration(seconds: 2),
              behavior: SnackBarBehavior.floating,
            ),
          );
      },
      icon: FaIcon(icon, color: warna),
    );
  }
}
