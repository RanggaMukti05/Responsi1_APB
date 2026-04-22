import 'package:flutter/material.dart';

class SocialButtonPage extends StatelessWidget {
  const SocialButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Social Button'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSocialCard(
              title: 'Social Button',
              subtitle: 'Default social button style',
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _socialBtn('f', const Color(0xFF3B5998)),
                  _socialBtn('G+', const Color(0xFFDB4437)),
                  _socialBtn('in', const Color(0xFF007BB6)),
                  _socialBtn('t', const Color(0xFF1DA1F2)),
                  _socialBtn('y', const Color(0xFFEE1C1C)),
                  _socialBtn('ig', const Color(0xFFC13584)),
                  _socialBtn('p', const Color(0xFFCB2027)),
                  _socialBtn('w', const Color(0xFF25D366)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSocialCard(
              title: 'Social Button Light',
              subtitle: 'Add .btn-social-icon-light to change the style',
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _socialBtn('f', const Color(0xFF3B5998), isLight: true),
                  _socialBtn('G+', const Color(0xFFDB4437), isLight: true),
                  _socialBtn('in', const Color(0xFF007BB6), isLight: true),
                  _socialBtn('t', const Color(0xFF1DA1F2), isLight: true),
                  _socialBtn('y', const Color(0xFFEE1C1C), isLight: true),
                  _socialBtn('ig', const Color(0xFFC13584), isLight: true),
                  _socialBtn('p', const Color(0xFFCB2027), isLight: true),
                  _socialBtn('w', const Color(0xFF25D366), isLight: true),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSocialCard(
              title: 'Social Button Circle',
              subtitle: 'Add .btn-social-icon-circle to change the style',
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _socialBtn('f', const Color(0xFF3B5998), isCircle: true),
                  _socialBtn('G+', const Color(0xFFDB4437), isCircle: true),
                  _socialBtn('in', const Color(0xFF007BB6), isCircle: true),
                  _socialBtn('t', const Color(0xFF1DA1F2), isCircle: true),
                  _socialBtn('y', const Color(0xFFEE1C1C), isCircle: true),
                  _socialBtn('ig', const Color(0xFFC13584), isCircle: true),
                  _socialBtn('p', const Color(0xFFCB2027), isCircle: true),
                  _socialBtn('w', const Color(0xFF25D366), isCircle: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialCard({required String title, required String subtitle, required Widget child}) {
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

  Widget _socialBtn(String label, Color color, {bool isLight = false, bool isCircle = false}) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: isLight ? color.withOpacity(0.15) : color,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle ? null : BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: isLight ? color : Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}