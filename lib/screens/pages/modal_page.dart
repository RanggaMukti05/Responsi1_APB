import 'package:flutter/material.dart';

class ModalPage extends StatelessWidget {
  const ModalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Modal'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildModalCard(
              context,
              title: 'Bootstrap Modal',
              subtitle: 'Default modal style',
              buttonLabel: 'Modal Basic',
              onPressed: () => _showBasicModal(context),
            ),
            const SizedBox(height: 20),
            _buildModalCard(
              context,
              title: 'Modal Centered',
              subtitle: 'Vertically centered modal',
              buttonLabel: 'Modal Center',
              onPressed: () => _showCenteredModal(context),
            ),
            const SizedBox(height: 20),
            _buildModalCard(
              context,
              title: 'Modal Large',
              subtitle: 'Large size modal',
              buttonLabel: 'Modal Large',
              onPressed: () => _showLargeModal(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModalCard(BuildContext context,
      {required String title,
      required String subtitle,
      required String buttonLabel,
      required VoidCallback onPressed}) {
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
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8E44AD),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              child: Text(buttonLabel),
            ),
          ),
        ],
      ),
    );
  }

  void _showBasicModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: const Text('Modal title', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
            'Modal body text goes here. Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8E44AD)),
            child: const Text('Save changes', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showCenteredModal(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Material(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('Modal title',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                const Divider(height: 1),
                const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('This is a vertically centered modal.'),
                ),
                const Divider(height: 1),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Close')),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF8E44AD)),
                          child: const Text('Save changes',
                              style: TextStyle(color: Colors.white))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showLargeModal(BuildContext context) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            margin: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Material(
              borderRadius: BorderRadius.circular(12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('Modal title',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  const Divider(height: 1),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                        'This is a larger modal that takes up more space at the top of the screen.'),
                  ),
                  const Divider(height: 1),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close')),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8E44AD)),
                            child: const Text('Save changes',
                                style: TextStyle(color: Colors.white))),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}