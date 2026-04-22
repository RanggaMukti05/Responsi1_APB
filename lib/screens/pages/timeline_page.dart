import 'package:flutter/material.dart';

class TimelinePage extends StatelessWidget {
  const TimelinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Timeline'),
        actions: const [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTimelineCard(
              title: 'Timeline',
              subtitle: 'Default timeline style',
              items: [
                _TimelineItemData(
                  title: '10 minutes ago',
                  content: 'Youtube, a video-sharing website, goes live',
                  color: const Color(0xFF8E44AD),
                ),
                _TimelineItemData(
                  title: '20 minutes ago',
                  content: 'Mashable, a news website and blog, goes live',
                  color: const Color(0xFF3498DB),
                ),
                _TimelineItemData(
                  title: '30 minutes ago',
                  content: 'Google acquired YouTube',
                  color: const Color(0xFF2ECC71),
                ),
                _TimelineItemData(
                  title: '15 minutes ago',
                  content: 'Stripe goes live',
                  color: const Color(0xFFD9534F),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineCard({
    required String title,
    required String subtitle,
    required List<_TimelineItemData> items,
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
          Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const Divider(height: 30),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return _buildTimelineItem(
                items[index],
                isLast: index == items.length - 1,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(_TimelineItemData item, {required bool isLast}) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: item.color,
                  shape: BoxShape.circle,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey.shade300,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1F2937),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.content,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20), 
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _TimelineItemData {
  final String title;
  final String content;
  final Color color;

  _TimelineItemData({
    required this.title,
    required this.content,
    required this.color,
  });
}