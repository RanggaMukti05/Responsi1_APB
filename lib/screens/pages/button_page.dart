import 'package:flutter/material.dart';

class ButtonPage extends StatelessWidget {
  const ButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Button'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildButtonCard(
              title: 'Buttons',
              subtitle: 'Default button style',
              isSquare: false,
            ),
            const SizedBox(height: 20),
            
            _buildButtonCard(
              title: 'Square Buttons',
              subtitle: 'add .btn-square to change the style',
              isSquare: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonCard({
    required String title,
    required String subtitle,
    required bool isSquare,
  }) {
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
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _customButton('Primary', const Color(0xFF8E44AD), isSquare),
              _customButton('Secondary', const Color(0xFF3498DB), isSquare),
              _customButton('Success', const Color(0xFF2ECC71), isSquare),
              _customButton('Danger', const Color(0xFFD9534F), isSquare),
              _customButton('Warning', const Color(0xFFF0AD4E), isSquare),
              _customButton('Info', const Color(0xFF5BC0DE), isSquare),
              _customButton('Light', const Color(0xFFF8F9FA), isSquare, textColor: Colors.grey),
              _customButton('Dark', Colors.black, isSquare),
            ],
          ),
        ],
      ),
    );
  }

  Widget _customButton(String label, Color bgColor, bool isSquare, {Color textColor = Colors.white}) {
    return Container(
      width: 100, 
      height: 45,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(isSquare ? 0 : 8),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}