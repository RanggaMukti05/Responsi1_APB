import 'package:flutter/material.dart';

class ProgressBarPage extends StatelessWidget {
  const ProgressBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Progress Bar'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildProgressCard(
              title: 'Default Progress Bars',
              subtitle: 'Default progress bar style',
              children: [
                _buildProgressItem(0.6, const Color(0xFF8E44AD)),
                _buildProgressItem(0.85, const Color(0xFF3498DB)),
                _buildProgressItem(0.4, const Color(0xFF2ECC71)),
                _buildProgressItem(0.6, const Color(0xFF5BC0DE)),
                _buildProgressItem(0.8, const Color(0xFFF0AD4E)),
                _buildProgressItem(0.9, const Color(0xFFD9534F)),
              ],
            ),
            const SizedBox(height: 20),
            _buildProgressCard(
              title: 'Striped Progress Bars',
              subtitle: 'Add .progress-bar-striped to change the style',
              children: [
                _buildProgressItem(0.1, const Color(0xFF5BC0DE)),
                _buildProgressItem(0.25, const Color(0xFF2ECC71)),
                _buildProgressItem(0.5, const Color(0xFFF0AD4E)),
                _buildProgressItem(0.75, const Color(0xFFD9534F)),
                _buildProgressItem(0.9, const Color(0xFF8E44AD)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard({
    required String title,
    required String subtitle,
    required List<Widget> children,
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
          ...children,
        ],
      ),
    );
  }

  Widget _buildProgressItem(double value, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: value,
          minHeight: 12,
          backgroundColor: Colors.grey.shade200,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}