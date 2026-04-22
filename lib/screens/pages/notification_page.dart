import 'package:flutter/material.dart';
import '../models/notification_model.dart'; 

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NotificationItem> notifications = [
      NotificationItem(
        title: 'Apply Success',
        subtitle: 'You has apply an job in Queenify Group as UI Designer',
        time: '10h ago',
        type: NotificationType.applySuccess,
        isUnread: true, 
      ),
      NotificationItem(
        title: 'Complete your profile',
        subtitle: 'Please verify your profile information to continue using this app',
        time: '10h ago',
        type: NotificationType.completeProfile,
      ),
      NotificationItem(
        title: 'Apply Success',
        subtitle: 'You has apply an job in Queenify Group as UI Designer',
        time: '10h ago',
        type: NotificationType.applySuccess,
      ),
      NotificationItem(
        title: 'Interview Calls',
        subtitle: 'Congratulations, you has apply an job call Interview in PT Sinergi Global.',
        time: '12h ago',
        type: NotificationType.interviewCalls,
      ),
    ];

    const Color unreadBorderColor = Color(0xFFE8F1FE); 
    const Color generalTextColor = Color(0xFF6B7280); 
    const Color timeIconColor = Color(0xFFBDBDBD); 
    const Color markAsReadColor = Color(0xFF5D78FF); 

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), 
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20.0), 
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 16), 
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Container(
            padding: const EdgeInsets.all(20.0), 
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12), 
              border: Border.all(
                color: item.isUnread ? unreadBorderColor : const Color(0xFFF1F1F1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.015),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
             
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1F2937), 
                  ),
                ),
                const SizedBox(height: 10),
                
                Text(
                  item.subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.5, 
                    color: generalTextColor, 
                  ),
                ),
                const SizedBox(height: 20),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
              
                    Row(
                      children: [
                        const Icon(
                          Icons.access_time_filled_rounded,
                          color: timeIconColor,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          item.time,
                          style: const TextStyle(
                            fontSize: 14,
                            color: generalTextColor,
                          ),
                        ),
                      ],
                    ),
                    if (item.isUnread)
                      GestureDetector(
                        onTap: () {
                        },
                        child: const Text(
                          'Mark as read',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: markAsReadColor, 
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}