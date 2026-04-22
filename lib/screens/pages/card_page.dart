import 'package:flutter/material.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Cards'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildStandardCard(
              title: 'Card Title',
              content: 'He lay on his armour-like back, and if he lifted his head a little he could see his brown belly, slightly domed and divided by arches into stiff sections. The bedding was hardly able to cover it and seemed ready to slide off any moment.',
              footer: 'Card footer',
              linkText: 'Card link',
            ),
            const SizedBox(height: 20),

            _buildStandardCard(
              title: 'Card Title',
              content: 'This is a wider card with supporting text and below as a natural lead-in to the additional content. This content',
              buttonLabel: 'Go somewhere',
              footer: 'Last updated 3 min ago',
            ),
            const SizedBox(height: 20),

            _buildColorCard(
              title: 'Primary Card Title',
              color: const Color(0xFF8E44AD),
              buttonTextColor: const Color(0xFF8E44AD),
            ),
            const SizedBox(height: 16),
            _buildColorCard(
              title: 'Secondary Card Title',
              color: const Color(0xFF3498DB),
              buttonTextColor: const Color(0xFF3498DB),
            ),
            const SizedBox(height: 16),
            _buildColorCard(
              title: 'Success Card Title',
              color: const Color(0xFF2ECC71),
              buttonTextColor: const Color(0xFF2ECC71),
            ),
            const SizedBox(height: 16),
            _buildColorCard(
              title: 'Danger Card Title',
              color: const Color(0xFFD9534F),
              buttonTextColor: const Color(0xFFD9534F),
            ),
            const SizedBox(height: 16),
            
            _buildColorCard(
              title: 'Light Card Title',
              color: const Color(0xFFF8F9FA),
              contentColor: Colors.grey[700],
              titleColor: Colors.black87,
              buttonColor: Colors.black,
              buttonTextColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStandardCard({
    required String title,
    required String content,
    String? footer,
    String? linkText,
    String? buttonLabel,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                Text(content, style: TextStyle(color: Colors.grey[600], height: 1.5)),
                if (buttonLabel != null) ...[
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8E44AD),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(buttonLabel, style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ],
            ),
          ),
          if (footer != null || linkText != null) ...[
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (footer != null) Text(footer, style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  if (linkText != null) 
                    Text(linkText, style: const TextStyle(color: Color(0xFF8E44AD), fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildColorCard({
    required String title,
    required Color color,
    Color? titleColor = Colors.white,
    Color? contentColor = Colors.white,
    Color? buttonColor = Colors.white,
    required Color buttonTextColor,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: titleColor)),
                const Divider(color: Colors.white24, height: 30),
                Text(
                  "Some quick example text to build on the card title and make up the bulk of the card's content.",
                  style: TextStyle(color: contentColor, height: 1.5),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: buttonColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text(buttonLabel ?? 'Go somewhere', style: TextStyle(color: buttonTextColor)),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Text('Last updated 3 min ago', style: TextStyle(color: contentColor?.withOpacity(0.8), fontSize: 12)),
          ),
        ],
      ),
    );
  }

  static const String? buttonLabel = "Go somewhere";
}