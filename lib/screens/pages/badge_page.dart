import 'package:flutter/material.dart';

class BadgePage extends StatelessWidget {
  const BadgePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Badge'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // SEKSI 1: BADGES SIZE
            _buildCardContainer(
              title: 'Badges Size',
              subtitle: 'Default Bootstrap Badges',
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _customBadge('Danger', const Color(0xFFD9534F), isLight: true),
                  _customBadge('Secondary', const Color(0xFF3498DB), isLight: true),
                  _customBadge('Primary', const Color(0xFF2ECC71), isLight: true), // Berwarna hijau di gambar
                ],
              ),
            ),
            const SizedBox(height: 20),

            // SEKSI 2: BADGES LIGHT
            _buildCardContainer(
              title: 'Badges Light',
              subtitle: 'Default Bootstrap Badges',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _customBadge('Primary', const Color(0xFF8E44AD), isLight: true),
                      _customBadge('Secondary', const Color(0xFF3498DB), isLight: true),
                      _customBadge('Success', const Color(0xFF2ECC71), isLight: true),
                      _customBadge('Danger', const Color(0xFFD9534F), isLight: true),
                      _customBadge('Warning', const Color(0xFFF0AD4E), isLight: true),
                      _customBadge('Info', const Color(0xFF5BC0DE), isLight: true),
                      _customBadge('Light', Colors.grey.shade400, isLight: true, textColor: Colors.black87),
                      _customBadge('Dark', Colors.grey.shade700, isLight: false), // Dark memakai background solid
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Angka 1 sampai 8
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      _numberBadge('1', const Color(0xFF8E44AD), isLight: true),
                      _numberBadge('2', const Color(0xFF3498DB), isLight: true),
                      _numberBadge('3', const Color(0xFF2ECC71), isLight: true),
                      _numberBadge('4', const Color(0xFFD9534F), isLight: true),
                      _numberBadge('5', const Color(0xFFF0AD4E), isLight: true),
                      _numberBadge('6', const Color(0xFF5BC0DE), isLight: true),
                      _numberBadge('7', Colors.grey.shade400, isLight: true, textColor: Colors.black87),
                      _numberBadge('8', Colors.grey.shade700, isLight: false),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // SEKSI 3: BADGES (SOLID COLORS)
            _buildCardContainer(
              title: 'Badges',
              subtitle: 'Default Bootstrap Badges',
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _customBadge('Primary', const Color(0xFF8E44AD)),
                  _customBadge('Secondary', const Color(0xFF3498DB)),
                  _customBadge('Success', const Color(0xFF2ECC71)),
                  _customBadge('Danger', const Color(0xFFD9534F)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membungkus konten dalam card putih
  Widget _buildCardContainer({required String title, required String subtitle, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const Divider(height: 30),
          child,
        ],
      ),
    );
  }

  // Widget pembuat Badge Teks
  Widget _customBadge(String text, Color color, {bool isLight = false, Color? textColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isLight ? color.withOpacity(0.15) : color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? (isLight ? color : Colors.white),
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
      ),
    );
  }

  // Widget pembuat Badge Angka (Kotak kecil)
  Widget _numberBadge(String number, Color color, {bool isLight = false, Color? textColor}) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: isLight ? color.withOpacity(0.15) : color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          number,
          style: TextStyle(
            color: textColor ?? (isLight ? color : Colors.white),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
