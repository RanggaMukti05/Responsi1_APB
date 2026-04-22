import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchPage extends StatefulWidget {
  const SwitchPage({super.key});

  @override
  State<SwitchPage> createState() => _SwitchPageState();
}

class _SwitchPageState extends State<SwitchPage> {
  bool isDefaultOn = true;
  bool isDefaultOff = false;
  bool isPrimary = true;
  bool isSuccess = true;
  bool isDanger = true;
  bool isWarning = true;
  bool isInfo = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Switch'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSwitchCard(
              title: 'Default Switch',
              subtitle: 'Default switch style',
              child: Column(
                children: [
                  _switchRow("Default switch", isDefaultOn, (val) => setState(() => isDefaultOn = val)),
                  _switchRow("Default switch", isDefaultOff, (val) => setState(() => isDefaultOff = val)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildSwitchCard(
              title: 'Contextual Switch',
              subtitle: 'Switch with different colors',
              child: Column(
                children: [
                  _switchRow("Primary switch", isPrimary, (val) => setState(() => isPrimary = val), color: const Color(0xFF8E44AD)),
                  _switchRow("Success switch", isSuccess, (val) => setState(() => isSuccess = val), color: const Color(0xFF2ECC71)),
                  _switchRow("Danger switch", isDanger, (val) => setState(() => isDanger = val), color: const Color(0xFFD9534F)),
                  _switchRow("Warning switch", isWarning, (val) => setState(() => isWarning = val), color: const Color(0xFFF0AD4E)),
                  _switchRow("Info switch", isInfo, (val) => setState(() => isInfo = val), color: const Color(0xFF5BC0DE)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSwitchCard({required String title, required String subtitle, required Widget child}) {
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

  Widget _switchRow(String label, bool value, Function(bool) onChanged, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
          CupertinoSwitch(
            value: value,
            activeColor: color ?? const Color(0xFF8E44AD),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}