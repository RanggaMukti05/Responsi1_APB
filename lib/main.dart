import 'package:flutter/material.dart';
import 'package:responsi1apb/screens/onboarding/splash_screen.dart';

// --- GLOBAL VARIABLES (Pengeras Suara) ---
// Bisa dipanggil dari file mana aja tanpa perlu ribet
final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);
final ValueNotifier<Color> colorNotifier = ValueNotifier(const Color(0xFF6F42C1));

void main() {
  runApp(const JobieApp());
}

class JobieApp extends StatelessWidget {
  const JobieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: colorNotifier,
      builder: (_, primaryColor, __) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (_, currentMode, __) {
            return MaterialApp(
              title: 'Jobie Mobile App',
              debugShowCheckedModeBanner: false,
              themeMode: currentMode, // Mengikuti mode saat ini (Light/Dark)
              
              // --- 1. ATURAN TEMA TERANG (LIGHT) ---
              theme: ThemeData(
                fontFamily: 'Poppins',
                brightness: Brightness.light,
                primaryColor: primaryColor, // Mengikuti warna palet yang dipilih
                scaffoldBackgroundColor: const Color(0xFFF5F5F5),
                cardColor: Colors.white,
                dividerColor: const Color(0xFFE4E4E4),
                textTheme: const TextTheme(
                  bodyLarge: TextStyle(color: Color(0xFF212529)), // Warna teks judul
                  bodyMedium: TextStyle(color: Color(0xFF8E8E93)), // Warna teks deskripsi
                ),
              ),
              
              // --- 2. ATURAN TEMA GELAP (DARK) ---
              darkTheme: ThemeData(
                fontFamily: 'Poppins',
                brightness: Brightness.dark,
                primaryColor: primaryColor, // Mengikuti warna palet yang dipilih
                scaffoldBackgroundColor: const Color(0xFF121212), // Background gelap pekat
                cardColor: const Color(0xFF1E1E1E), // Warna kotak card gelap
                dividerColor: const Color(0xFF2C2C2C), // Garis pembatas gelap
                textTheme: const TextTheme(
                  bodyLarge: TextStyle(color: Colors.white),
                  bodyMedium: TextStyle(color: Colors.white70),
                ),
              ),
              
              home: const SplashScreen(),
            );
          },
        );
      },
    );
  }
}