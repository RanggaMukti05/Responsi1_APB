import 'package:flutter/material.dart';

class TreeviewPage extends StatelessWidget {
  const TreeviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Tree View'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTreeCard(
              title: 'Default Tree View',
              subtitle: 'Default tree view style',
              child: Column(
                children: [
                  _buildTreeItem('Main'),
                  _buildTreeItem('New Scene', isSelected: true),
                  _buildTreeItem('Scripts', hasChildren: true, children: [
                    _buildTreeItem('PlayerController'),
                    _buildTreeItem('CameraController'),
                  ]),
                  _buildTreeItem('Prefabs', hasChildren: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTreeCard({required String title, required String subtitle, required Widget child}) {
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

  Widget _buildTreeItem(String label, {bool isSelected = false, bool hasChildren = false, List<Widget>? children}) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF8E44AD) : Colors.transparent,
            borderRadius: BorderRadius.circular(4),
          ),
          child: ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            leading: Icon(
              hasChildren ? Icons.folder_open_rounded : Icons.insert_drive_file_outlined,
              size: 18,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
            title: Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[800],
                fontSize: 14,
              ),
            ),
            trailing: hasChildren 
                ? Icon(Icons.keyboard_arrow_down, size: 18, color: isSelected ? Colors.white : Colors.grey) 
                : null,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
        ),
        if (children != null)
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(children: children),
          ),
      ],
    );
  }
}
