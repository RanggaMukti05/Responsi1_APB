import 'package:flutter/material.dart';

class InputPage extends StatelessWidget {
  const InputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Input'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInputCard(
              title: 'Input',
              subtitle: 'Default input style',
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Input text...',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),

            _buildInputCard(
              title: 'Input with Icon',
              subtitle: 'Input with prefix or suffix icon',
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF8E44AD)),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: const Icon(Icons.visibility_off, color: Colors.grey),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            _buildInputCard(
              title: 'Input Group',
              subtitle: 'Input with addons',
              child: Column(
                children: [
                  _buildInputAddon(prefix: '@', hint: 'Username'),
                  const SizedBox(height: 15),
                  _buildInputAddon(suffix: '.00', hint: 'Amount'),
                  const SizedBox(height: 15),
                  _buildInputAddon(prefix: 'https://', suffix: '.com', hint: 'URL'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard({required String title, required String subtitle, required Widget child}) {
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

  Widget _buildInputAddon({String? prefix, String? suffix, required String hint}) {
    return Row(
      children: [
        if (prefix != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
            ),
            child: Text(prefix, style: const TextStyle(color: Colors.black54)),
          ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.horizontal(
                  left: prefix != null ? Radius.zero : const Radius.circular(8),
                  right: suffix != null ? Radius.zero : const Radius.circular(8),
                ),
              ),
            ),
          ),
        ),
        if (suffix != null)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(8)),
            ),
            child: Text(suffix, style: const TextStyle(color: Colors.black54)),
          ),
      ],
    );
  }
}