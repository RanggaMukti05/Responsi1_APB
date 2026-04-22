import 'package:flutter/material.dart';

class ListGroupPage extends StatelessWidget {
  const ListGroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('List Group'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildListCard(
              title: 'Basic List Group',
              subtitle: 'Default list group style',
              children: [
                _buildListItem('Cras justo odio'),
                _buildListItem('Dapibus ac facilisis in'),
                _buildListItem('Morbi leo risus'),
                _buildListItem('Porta ac consectetur ac'),
                _buildListItem('Vestibulum at eros'),
              ],
            ),
            const SizedBox(height: 20),
            _buildListCard(
              title: 'List Group With Badges',
              subtitle: 'Default list group style',
              children: [
                _buildListItemWithBadge('Cras justo odio', '14', const Color(0xFF8E44AD)),
                _buildListItemWithBadge('Dapibus ac facilisis in', '2', const Color(0xFF3498DB)),
                _buildListItemWithBadge('Morbi leo risus', '1', const Color(0xFF2ECC71)),
              ],
            ),
            const SizedBox(height: 20),
            _buildListCard(
              title: 'List Group Contextual',
              subtitle: 'Default list group style',
              children: [
                _buildListItem('Dapibus ac facilisis in'),
                _buildListItem('List group item Primary', color: const Color(0xFFE7D9F5), textColor: const Color(0xFF8E44AD)),
                _buildListItem('List group item Secondary', color: const Color(0xFFE1F0FA), textColor: const Color(0xFF3498DB)),
                _buildListItem('List group item Success', color: const Color(0xFFE6F9EE), textColor: const Color(0xFF2ECC71)),
                _buildListItem('List group item Danger', color: const Color(0xFFFCEBEA), textColor: const Color(0xFFD9534F)),
                _buildListItem('List group item Warning', color: const Color(0xFFFEF7EC), textColor: const Color(0xFFF0AD4E)),
                _buildListItem('List group item Info', color: const Color(0xFFEBF8FC), textColor: const Color(0xFF5BC0DE)),
                _buildListItem('List group item Light', color: const Color(0xFFF8F9FA), textColor: Colors.black54),
                _buildListItem('List group item Dark', color: const Color(0xFFD1D2D3), textColor: Colors.black87),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListCard({required String title, required String subtitle, required List<Widget> children}) {
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
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildListItem(String text, {Color? color, Color? textColor}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Text(
        text,
        style: TextStyle(color: textColor ?? Colors.grey[700], fontSize: 14),
      ),
    );
  }

  Widget _buildListItemWithBadge(String text, String badgeCount, Color badgeColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(color: Colors.grey[700], fontSize: 14)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: badgeColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badgeCount,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}