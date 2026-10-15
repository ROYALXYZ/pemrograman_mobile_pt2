import 'package:flutter/material.dart';

/// Baris tombol aksi profil berisi tombol Edit dan Bagikan.
///
/// Dipisah dari ProfileScreen agar ProfileScreen tidak lagi merangkai tombol
/// secara langsung, dan baris tombol ini bisa dipakai ulang di halaman lain.
class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.edit),
          label: const Text('Edit'),
        ),
        ElevatedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.share),
          label: const Text('Bagikan'),
        ),
      ],
    );
  }
}
