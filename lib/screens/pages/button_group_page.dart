import 'package:flutter/material.dart';

class ButtonGroupPage extends StatelessWidget {
  const ButtonGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Button Group'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCardContainer(
              title: 'Button Group',
              subtitle: 'Default Button group style',
              child: _buildGroupedButtons(['Left', 'Middle', 'Right']),
            ),
            const SizedBox(height: 20),

            _buildCardContainer(
              title: 'Button Toolbar',
              subtitle: 'Default Button toolbar style',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGroupedButtons(['1', '2', '3', '4'], isSmall: true),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _buildGroupedButtons(['5', '6', '7'], isSmall: true),
                      const SizedBox(width: 10),
                      _buildGroupedButtons(['8'], isSmall: true), 
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildCardContainer(
              title: 'Button Sizing',
              subtitle: 'Default button size style',
              child: _buildGroupedButtons(['Left', 'Middle', 'Right'], height: 55), 
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _buildGroupedButtons(List<String> labels, {double height = 45, bool isSmall = false}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF7239EA), 
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: labels.asMap().entries.map((entry) {
          int index = entry.key;
          String label = entry.value;
          bool isLast = index == labels.length - 1;

          return Row(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: isSmall ? 22 : 24),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              if (!isLast)
                Container(
                  width: 1,
                  height: height,
                  color: Colors.white.withOpacity(0.3),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}