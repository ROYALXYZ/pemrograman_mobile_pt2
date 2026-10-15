import 'package:flutter/material.dart';
import '../widgets/action_buttons.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_info.dart';
import '../widgets/social_media_row.dart';
import 'about_screen.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'Tentang Aplikasi',
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AboutScreen()),
              );
            },
          ),
        ],
      ),
      // Catatan penting: Expanded sengaja diletakkan DI LUAR
      // SingleChildScrollView. Column di dalam scroll view menerima
      // unbounded height constraints, sehingga anak dengan flex akan membuat
      // Flutter melempar error:
      // "RenderFlex children have non-zero flex but incoming height
      //  constraints are unbounded."
      // Expanded di luar scroll view membuat Column ini punya tinggi
      // terbatas, sehingga pembagian flex di bawahnya valid.
      body: SafeArea(
        child: Column(
          children: [
            // 3 dari 4 ruang untuk foto profil dan informasi. Isi yang lebih
            // panjang dari layar tetap bisa digulir karena isinya dibungkus
            // SingleChildScrollView.
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 24),
                      const ProfileHeader(
                        name: 'Rangga Pasha Cucu Wibisono',
                        nim: '25.11.6570',
                        photoRadius: 60,
                      ),
                      const ProfileInfo(
                        programStudi: 'S1 Informatika',
                        email: 'r.pasha@students.amikom.ac.id',
                        lokasi: 'Yogyakarta, Indonesia',
                      ),
                      const SizedBox(height: 24),
                      const SocialMediaRow(),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),

            // 1 dari 4 ruang untuk tombol aksi. Flexible memakai
            // FlexFit.loose, jadi tombol tetap setinggi alaminya dan tidak
            // dipaksa mengisi seluruh jatah ruangnya.
            Flexible(
              flex: 1,
              child: Center(child: const ActionButtons()),
            ),
          ],
        ),
      ),
    );
  }
}