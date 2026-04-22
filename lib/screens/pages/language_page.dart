import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selectedLanguage = 'English';

  final List<Map<String, String>> _languages = [
    {'name': 'English', 'flag': '🇺🇸'},
    {'name': 'Indonesia', 'flag': '🇮🇩'},
    {'name': 'French', 'flag': '🇫🇷'},
    {'name': 'German', 'flag': '🇩🇪'},
    {'name': 'Spanish', 'flag': '🇪🇸'},
    {'name': 'Chinese', 'flag': '🇨🇳'},
    {'name': 'Japanese', 'flag': '🇯🇵'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Language'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildLanguageCard(
              title: 'Select Language',
              subtitle: 'Default language selection style',
              child: Column(
                children: _languages.map((lang) {
                  bool isSelected = _selectedLanguage == lang['name'];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF8E44AD).withOpacity(0.05) : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF8E44AD) : Colors.grey.shade200,
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          _selectedLanguage = lang['name']!;
                        });
                      },
                      leading: Text(
                        lang['flag']!,
                        style: const TextStyle(fontSize: 24),
                      ),
                      title: Text(
                        lang['name']!,
                        style: TextStyle(
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          color: isSelected ? const Color(0xFF8E44AD) : Colors.black87,
                        ),
                      ),
                      trailing: isSelected
                          ? const Icon(Icons.check_circle, color: Color(0xFF8E44AD))
                          : const Icon(Icons.circle_outlined, color: Colors.grey),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageCard({required String title, required String subtitle, required Widget child}) {
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