// Widget test untuk aplikasi Profil Mahasiswa.
//
// Berkas ini menggantikan smoke test bawaan `flutter create` yang menguji
// aplikasi counter, karena aplikasi ini sudah tidak memakai counter sama sekali.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:profil_mahasiswa/main.dart';
import 'package:profil_mahasiswa/screens/about_screen.dart';
import 'package:profil_mahasiswa/widgets/action_buttons.dart';
import 'package:profil_mahasiswa/widgets/profile_header.dart';
import 'package:profil_mahasiswa/widgets/profile_info.dart';
import 'package:profil_mahasiswa/widgets/social_media_row.dart';

void main() {
  /// Menjalankan aplikasi pada ukuran layar tertentu supaya hasil pengukuran
  /// tidak bergantung pada ukuran jendela default test runner.
  Future<void> jalankan(WidgetTester tester, {Size layar = const Size(400, 800)}) async {
    tester.view.physicalSize = layar;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();
  }

  group('Halaman Profil', () {
    testWidgets('menampilkan seluruh data profil', (WidgetTester tester) async {
      await jalankan(tester);

      expect(find.text('Profil Mahasiswa'), findsOneWidget);
      expect(find.text('Rangga Pasha Cucu Wibisono'), findsOneWidget);
      expect(find.text('NIM: 25.11.6570'), findsOneWidget);
      expect(find.text('S1 Informatika'), findsOneWidget);
      expect(find.text('r.pasha@students.amikom.ac.id'), findsOneWidget);
      expect(find.text('Yogyakarta, Indonesia'), findsOneWidget);
    });

    testWidgets('merakit widget terpisah, bukan widget inline', (
      WidgetTester tester,
    ) async {
      await jalankan(tester);

      // Widget hasil refactoring Latihan 4 harus benar-benar dipakai.
      expect(find.byType(ProfileHeader), findsOneWidget);
      expect(find.byType(ProfileInfo), findsOneWidget);
      expect(find.byType(SocialMediaRow), findsOneWidget);
      expect(find.byType(ActionButtons), findsOneWidget);
    });

    testWidgets('tidak mengalami overflow di berbagai ukuran layar', (
      WidgetTester tester,
    ) async {
      for (final layar in [
        const Size(400, 800),
        const Size(400, 420),
        const Size(400, 320),
        const Size(320, 568),
      ]) {
        tester.view.physicalSize = layar;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.reset);

        await tester.pumpWidget(const MyApp());
        await tester.pumpAndSettle();

        expect(tester.takeException(), isNull, reason: 'overflow di $layar');
      }
    });
  });

  group('Pembagian ruang Expanded dan Flexible', () {
    testWidgets('meng bagi ruang dengan rasio 3 banding 1', (
      WidgetTester tester,
    ) async {
      await jalankan(tester);

      final expanded = tester.getSize(
        find.ancestor(
          of: find.byType(SocialMediaRow),
          matching: find.byType(Expanded),
        ),
      );
      final flexible = tester.getSize(
        find.ancestor(
          of: find.byType(ElevatedButton).first,
          matching: find.byType(Flexible),
        ),
      );

      // 800 - AppBar 56 = 744; 744 / 4 = 186; 186 * 3 = 558
      expect(expanded.height, 558);
      expect(flexible.height, 186);
    });

    testWidgets('tombol tetap tinggi alami dan tidak ikut ter-scroll', (
      WidgetTester tester,
    ) async {
      await jalankan(tester);

      final tombol = tester.getSize(find.byType(ElevatedButton).first);
      expect(tombol.height, 48);

      // Tombol berada di luar SingleChildScrollView, jadi posisinya tetap.
      await tester.drag(find.byType(SocialMediaRow), const Offset(0, -200));
      await tester.pumpAndSettle();

      expect(tester.getTopLeft(find.byType(ElevatedButton).first).dy, 683);
    });
  });

  group('SocialMediaRow', () {
    testWidgets('menampilkan tiga tombol media sosial', (
      WidgetTester tester,
    ) async {
      await jalankan(tester);

      expect(find.byType(IconButton), findsNWidgets(4)); // 3 sosial + 1 AppBar
      expect(find.byType(FaIcon), findsNWidgets(3));
    });

    testWidgets('menampilkan SnackBar sesuai tombol yang diklik', (
      WidgetTester tester,
    ) async {
      await jalankan(tester);

      await tester.tap(find.byType(IconButton).at(1));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 750));

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Membuka profil LinkedIn'), findsOneWidget);
    });
  });

  group('Navigasi ke AboutScreen', () {
    testWidgets('buka halaman Tentang lewat tombol AppBar', (
      WidgetTester tester,
    ) async {
      await jalankan(tester);

      await tester.tap(find.byIcon(Icons.info_outline));
      await tester.pumpAndSettle();

      expect(find.byType(AboutScreen), findsOneWidget);
      expect(find.text('Tentang Aplikasi'), findsOneWidget);
    });

    testWidgets('tombol Kembali menutup halaman Tentang', (
      WidgetTester tester,
    ) async {
      await jalankan(tester);

      await tester.tap(find.byIcon(Icons.info_outline));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.arrow_back));
      await tester.pumpAndSettle();

      expect(find.byType(AboutScreen), findsNothing);
      expect(find.byType(ProfileHeader), findsOneWidget);
    });
  });

  group('AboutScreen', () {
    testWidgets('gradien memenuhi seluruh layar', (
      WidgetTester tester,
    ) async {
      await jalankan(tester);

      await tester.tap(find.byIcon(Icons.info_outline));
      await tester.pumpAndSettle();

      // Hanya Container dengan gradien milik AboutScreen yang cocok.
      final gradien = find.byWidgetPredicate(
        (w) =>
            w is Container &&
            w.decoration is BoxDecoration &&
            (w.decoration! as BoxDecoration).gradient is LinearGradient,
      );

      // Latar harus setinggi layar penuh, bukan hanya setinggi isinya.
      expect(tester.getSize(gradien), const Size(400, 800));
    });
  });
}
