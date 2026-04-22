import 'package:flutter/material.dart';

class RadioButtonPage extends StatefulWidget {
  const RadioButtonPage({super.key});

  @override
  State<RadioButtonPage> createState() => _RadioButtonPageState();
}

class _RadioButtonPageState extends State<RadioButtonPage> {
  int? _squareValue = 1;
  int? _circleValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Radio Button'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildRadioCard(
              title: 'Square Radio',
              isSquare: true,
              selectedValue: _squareValue,
              onChanged: (value) => setState(() => _squareValue = value),
            ),
            const SizedBox(height: 20),
            
            _buildRadioCard(
              title: 'Circle Radio',
              isSquare: false,
              selectedValue: _circleValue,
              onChanged: (value) => setState(() => _circleValue = value),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioCard({
    required String title,
    required bool isSquare,
    required int? selectedValue,
    required ValueChanged<int?> onChanged,
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
          const Divider(height: 30),
          Column(
            children: List.generate(4, (index) {
              int val = index + 1;
              return Theme(
                data: Theme.of(context).copyWith(
                  unselectedWidgetColor: const Color(0xFF8E44AD), // Warna border saat tidak dipilih
                ),
                child: RadioListTile<int>(
                  value: val,
                  groupValue: selectedValue,
                  onChanged: onChanged,
                  activeColor: const Color(0xFF8E44AD), 
                  title: Text(
                    'Radio button 0$val',
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  shape: isSquare 
                    ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)) 
                    : const CircleBorder(),
                  secondary: isSquare ? null : null, 
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}