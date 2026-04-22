import 'package:flutter/material.dart';

class ToastPage extends StatelessWidget {
  const ToastPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Toast'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildToastCard(
              title: 'Toast Top Right',
              subtitle: 'Default toast style',
              buttonLabel: 'Top Right',
              onPressed: () => _showToast(context, Alignment.topRight, 'Top Right Toast'),
            ),
            const SizedBox(height: 20),
            _buildToastCard(
              title: 'Toast Top Left',
              subtitle: 'Default toast style',
              buttonLabel: 'Top Left',
              onPressed: () => _showToast(context, Alignment.topLeft, 'Top Left Toast'),
            ),
            const SizedBox(height: 20),
            _buildToastCard(
              title: 'Toast Bottom Right',
              subtitle: 'Default toast style',
              buttonLabel: 'Bottom Right',
              onPressed: () => _showToast(context, Alignment.bottomRight, 'Bottom Right Toast'),
            ),
            const SizedBox(height: 20),
            _buildToastCard(
              title: 'Toast Bottom Left',
              subtitle: 'Default toast style',
              buttonLabel: 'Bottom Left',
              onPressed: () => _showToast(context, Alignment.bottomLeft, 'Bottom Left Toast'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToastCard({
    required String title,
    required String subtitle,
    required String buttonLabel,
    required VoidCallback onPressed,
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E44AD),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: Text(buttonLabel),
            ),
          ),
        ],
      ),
    );
  }

  void _showToast(BuildContext context, Alignment alignment, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: alignment.y < 0 ? 50 : null,
        bottom: alignment.y > 0 ? 50 : null,
        left: alignment.x < 0 ? 20 : null,
        right: alignment.x > 0 ? 20 : null,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 250,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 15,
                          height: 15,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8E44AD),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text('Bootstrap', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                      ],
                    ),
                    const Text('11 mins ago', style: TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(message, style: const TextStyle(fontSize: 13)),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}
