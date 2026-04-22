import 'package:flutter/material.dart';

class TypographyPage extends StatelessWidget {
  const TypographyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Typography'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTypeCard(
              title: 'Headings',
              subtitle: 'Default headings style',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textRow('h1. Bootstrap heading', 36, FontWeight.w600),
                  _textRow('h2. Bootstrap heading', 30, FontWeight.w600),
                  _textRow('h3. Bootstrap heading', 24, FontWeight.w600),
                  _textRow('h4. Bootstrap heading', 18, FontWeight.w600),
                  _textRow('h5. Bootstrap heading', 16, FontWeight.w600),
                  _textRow('h6. Bootstrap heading', 14, FontWeight.w600),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildTypeCard(
              title: 'Display Headings',
              subtitle: 'Default display headings style',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textRow('Display 1', 60, FontWeight.w300),
                  _textRow('Display 2', 50, FontWeight.w300),
                  _textRow('Display 3', 40, FontWeight.w300),
                  _textRow('Display 4', 30, FontWeight.w300),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildTypeCard(
              title: 'Text Colors',
              subtitle: 'Default text color style',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textRow('This is Primary text color', 14, FontWeight.normal, color: const Color(0xFF8E44AD)),
                  _textRow('This is Secondary text color', 14, FontWeight.normal, color: const Color(0xFF3498DB)),
                  _textRow('This is Success text color', 14, FontWeight.normal, color: const Color(0xFF2ECC71)),
                  _textRow('This is Danger text color', 14, FontWeight.normal, color: const Color(0xFFD9534F)),
                  _textRow('This is Warning text color', 14, FontWeight.normal, color: const Color(0xFFF0AD4E)),
                  _textRow('This is Info text color', 14, FontWeight.normal, color: const Color(0xFF5BC0DE)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTypeCard({required String title, required String subtitle, required Widget child}) {
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

  Widget _textRow(String text, double size, FontWeight weight, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: size,
          fontWeight: weight,
          color: color ?? const Color(0xFF1F2937),
        ),
      ),
    );
  }
}