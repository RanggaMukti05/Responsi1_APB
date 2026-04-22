import 'package:flutter/material.dart';

class DividerPage extends StatelessWidget {
  const DividerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Divider'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDividerCard(
              title: 'Default Divider',
              subtitle: 'Default divider style',
              child: const Column(
                children: [
                  Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
                  Divider(height: 40, thickness: 1),
                  Text('Sed do eiusmod tempor incididunt ut labore et dolore.'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildDividerCard(
              title: 'Contextual Divider',
              subtitle: 'Divider with different colors',
              child: const Column(
                children: [
                  Text('Primary Divider'),
                  Divider(height: 30, thickness: 2, color: Color(0xFF8E44AD)),
                  Text('Success Divider'),
                  Divider(height: 30, thickness: 2, color: Color(0xFF2ECC71)),
                  Text('Danger Divider'),
                  Divider(height: 30, thickness: 2, color: Color(0xFFD9534F)),
                  Text('Warning Divider'),
                  Divider(height: 30, thickness: 2, color: Color(0xFFF0AD4E)),
                  Text('Info Divider'),
                  Divider(height: 30, thickness: 2, color: Color(0xFF5BC0DE)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildDividerCard(
              title: 'Vertical Divider',
              subtitle: 'Vertical divider style',
              child: SizedBox(
                height: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text('Item 1'),
                    const VerticalDivider(width: 20, thickness: 1),
                    const Text('Item 2'),
                    const VerticalDivider(width: 20, thickness: 1),
                    const Text('Item 3'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDividerCard({required String title, required String subtitle, required Widget child}) {
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
}