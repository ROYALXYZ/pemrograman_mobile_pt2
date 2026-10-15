import 'package:flutter/material.dart';
import 'profile_photo.dart';

/// Header profil berisi foto, nama, dan NIM.
///
/// Bagian ini dipisah dari [ProfileInfo] supaya ProfileScreen tidak perlu
/// merangkai elemen header satu per satu, dan setiap widget hanyaHandles satu
/// bagian dari tampilan profil.
class ProfileHeader extends StatelessWidget {
  final String name;
  final String nim;
  final double photoRadius;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.nim,
    this.photoRadius = 60,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProfilePhoto(radius: photoRadius),
        const SizedBox(height: 24),
        Text(
          name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'NIM: $nim',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
