import 'package:flutter/material.dart';

class DropdownPage extends StatelessWidget {
  const DropdownPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Dropdown'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildDropdownCard(
              title: 'Basic Dropdown',
              description: 'A dropdown menu is a toggleable menu that allows the user to choose one value from a predefined list',
              buttonLabel: 'Dropdown button',
            ),
            const SizedBox(height: 20),

            _buildDropdownCard(
              title: 'Dropdown Divider',
              description: 'The .dropdown-divider class is used to separate links inside the dropdown menu with a thin horizontal border',
              buttonLabel: 'Dropdown button',
            ),
            const SizedBox(height: 20),

            _buildDropdownCard(
              title: 'Dropup',
              description: 'The .dropup class makes the dropdown menu expand upwards instead of downwards',
              child: Row(
                children: [
                  _buildCustomButton('Dropup ▲'),
                  const SizedBox(width: 10),
                  _buildSplitButton('Split dropup', Icons.arrow_drop_up),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildDropdownCard(
              title: 'Dropright',
              description: 'Trigger dropdown menus at the right of the elements by adding .dropend to the parent element',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCustomButton('Dropright ▶', width: 140),
                  const SizedBox(height: 10),
                  _buildSplitButton('Split dropright', Icons.arrow_right, width: 200),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildDropdownCard(
              title: 'Dropstart',
              description: 'Trigger dropdown menus at the left of the elements by adding .dropstart to the parent element',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCustomButton('◀ Dropstart', width: 140),
                  const SizedBox(height: 10),
                  _buildSplitButton('Split dropstart', Icons.arrow_left, width: 200, isLeftIcon: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownCard({
    required String title,
    required String description,
    String? buttonLabel,
    Widget? child,
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
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.4),
          ),
          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 20),
          child ?? _buildCustomButton(buttonLabel ?? ''),
        ],
      ),
    );
  }

  Widget _buildCustomButton(String label, {double? width}) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8E44AD),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Text(label),
      ),
    );
  }

  Widget _buildSplitButton(String label, IconData icon, {double? width, bool isLeftIcon = false}) {
    return SizedBox(
      width: width,
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (isLeftIcon) ...[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF7D3C98),
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(8)),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
            ],
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF8E44AD),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(isLeftIcon ? 0 : 8),
                    right: Radius.circular(isLeftIcon ? 8 : 0),
                  ),
                ),
                child: Text(label, style: const TextStyle(color: Colors.white), textAlign: TextAlign.center),
              ),
            ),
            if (!isLeftIcon) ...[
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0xFF7D3C98),
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(8)),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
            ],
          ],
        ),
      ),
    );
  }
}