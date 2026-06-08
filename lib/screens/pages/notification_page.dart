import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> applications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMyApplications();
  }

  Future<void> _fetchMyApplications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      setState(() => isLoading = false);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/pelamar/applications'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          applications = data['data'];
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal memuat daftar lamaran')),
          );
        }
      }
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color unreadBorderColor = Color(0xFFE8F1FE); 
    const Color generalTextColor = Color(0xFF6B7280); 
    const Color timeIconColor = Color(0xFFBDBDBD); 
    const Color primaryColor = Color(0xFF6F42C1);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), 
      appBar: AppBar(
        title: const Text('Status Lamaran Saya'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : applications.isEmpty
              ? const Center(
                  child: Text(
                    'Anda belum melamar pekerjaan apapun.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20.0), 
                  itemCount: applications.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16), 
                  itemBuilder: (context, index) {
                    final app = applications[index];
                    final job = app['job'] ?? {};
                    final company = job['company'] ?? {};
                    final status = app['status']?.toString().toLowerCase() ?? 'pending';

                    Color statusColor;
                    String statusText;
                    IconData statusIcon;

                    if (status == 'accepted') {
                      statusColor = Colors.green;
                      statusText = 'DITERIMA';
                      statusIcon = Icons.check_circle;
                    } else if (status == 'rejected') {
                      statusColor = Colors.red;
                      statusText = 'DITOLAK';
                      statusIcon = Icons.cancel;
                    } else {
                      statusColor = Colors.orange;
                      statusText = 'MENUNGGU';
                      statusIcon = Icons.access_time_filled;
                    }

                    // Format date roughly
                    final createdAt = app['created_at'] != null 
                        ? DateTime.tryParse(app['created_at']) 
                        : null;
                    
                    String timeAgo = 'Baru saja';
                    if (createdAt != null) {
                      final difference = DateTime.now().difference(createdAt);
                      if (difference.inDays > 0) {
                        timeAgo = '${difference.inDays} hari yang lalu';
                      } else if (difference.inHours > 0) {
                        timeAgo = '${difference.inHours} jam yang lalu';
                      } else if (difference.inMinutes > 0) {
                        timeAgo = '${difference.inMinutes} menit yang lalu';
                      }
                    }

                    return Container(
                      padding: const EdgeInsets.all(20.0), 
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12), 
                        border: Border.all(
                          color: unreadBorderColor,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  job['title']?.toString() ?? 'Posisi Tidak Diketahui',
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1F2937), 
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: statusColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    Icon(statusIcon, size: 14, color: statusColor),
                                    const SizedBox(width: 4),
                                    Text(
                                      statusText,
                                      style: TextStyle(
                                        color: statusColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            company['nama_perusahaan']?.toString() ?? 'Perusahaan Tidak Diketahui',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time,
                                color: timeIconColor,
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Dikirim $timeAgo',
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: generalTextColor,
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