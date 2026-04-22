import 'package:flutter/material.dart';

class AlertPage extends StatelessWidget {
  const AlertPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Alert'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Basic Alerts',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Bootstrap default style',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 24),
              
              _buildAlertItem(
                text: 'Welcome! Message has been sent.',
                icon: Icons.sentiment_satisfied_alt,
                color: const Color(0xFF8E44AD), 
              ),
              _buildAlertItem(
                text: 'Done! Your profile photo updated.',
                icon: Icons.thumb_up_alt_outlined,
                color: const Color(0xFF3498DB), 
              ),
              _buildAlertItem(
                text: 'Success! Message has been sent.',
                icon: Icons.check_box_outlined,
                color: const Color(0xFF2ECC71), 
              ),
              _buildAlertItem(
                text: 'Info! You have got 5 new email.',
                icon: Icons.info_outline,
                color: const Color(0xFF5BC0DE),
              ),
              _buildAlertItem(
                text: 'Warning! Something went wrong. Please check.',
                icon: Icons.warning_amber_rounded,
                color: const Color(0xFFF0AD4E), 
              ),
              _buildAlertItem(
                text: 'Error! Message sending failed.',
                icon: Icons.cancel_outlined,
                color: const Color(0xFFD9534F), 
              ),
              _buildAlertItem(
                text: 'Error! You successfully read this important alert message.',
                icon: Icons.cancel_outlined,
                color: Colors.black, 
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertItem({
    required String text,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          const Icon(Icons.close, color: Colors.white, size: 16),
        ],
      ),
    );
  }
}