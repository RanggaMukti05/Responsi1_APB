import 'package:flutter/material.dart';

class SpinnerPage extends StatelessWidget {
  const SpinnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Spinner'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSpinnerCard(
              title: 'Border Spinner',
              subtitle: 'Default border spinner style',
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  _buildBorderSpinner(const Color(0xFF8E44AD)),
                  _buildBorderSpinner(const Color(0xFF3498DB)),
                  _buildBorderSpinner(const Color(0xFF2ECC71)),
                  _buildBorderSpinner(const Color(0xFFD9534F)),
                  _buildBorderSpinner(const Color(0xFFF0AD4E)),
                  _buildBorderSpinner(const Color(0xFF5BC0DE)),
                  _buildBorderSpinner(Colors.black87),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSpinnerCard(
              title: 'Growing Spinner',
              subtitle: 'Default growing spinner style',
              child: Wrap(
                spacing: 20,
                runSpacing: 20,
                children: [
                  _buildGrowingSpinner(const Color(0xFF8E44AD)),
                  _buildGrowingSpinner(const Color(0xFF3498DB)),
                  _buildGrowingSpinner(const Color(0xFF2ECC71)),
                  _buildGrowingSpinner(const Color(0xFFD9534F)),
                  _buildGrowingSpinner(const Color(0xFFF0AD4E)),
                  _buildGrowingSpinner(const Color(0xFF5BC0DE)),
                  _buildGrowingSpinner(Colors.black87),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpinnerCard({required String title, required String subtitle, required Widget child}) {
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

  Widget _buildBorderSpinner(Color color) {
    return SizedBox(
      width: 25,
      height: 25,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }

  Widget _buildGrowingSpinner(Color color) {
    return _GrowingSpinnerWidget(color: color);
  }
}

class _GrowingSpinnerWidget extends StatefulWidget {
  final Color color;
  const _GrowingSpinnerWidget({required this.color});

  @override
  State<_GrowingSpinnerWidget> createState() => _GrowingSpinnerWidgetState();
}

class _GrowingSpinnerWidgetState extends State<_GrowingSpinnerWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 750),
    )..repeat();
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: ReverseAnimation(_animation),
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: widget.color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}