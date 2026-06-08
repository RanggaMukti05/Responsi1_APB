import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CompanyApplicantsList extends StatefulWidget {
  const CompanyApplicantsList({super.key});

  @override
  State<CompanyApplicantsList> createState() => _CompanyApplicantsListState();
}

class _CompanyApplicantsListState extends State<CompanyApplicantsList> {
  List<dynamic> applicants = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchApplicants();
  }

  Future<void> _fetchApplicants() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    if (token == null) {
      setState(() => isLoading = false);
      return;
    }

    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/company/applicants'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          applicants = data['data'];
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal memuat data pelamar')),
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

  Future<void> _updateStatus(String appId, String newStatus) async {
    setState(() => isLoading = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    try {
      final response = await http.put(
        Uri.parse('http://127.0.0.1:8000/api/applications/$appId/status'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({'status': newStatus}),
      );

      if (response.statusCode == 200) {
        _fetchApplicants(); // Reload data
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Status berhasil diubah menjadi $newStatus')),
          );
        }
      } else {
        setState(() => isLoading = false);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal mengubah status')),
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
    const Color primaryColor = Color(0xFF6F42C1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Pelamar'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : applicants.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada pelamar.',
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: applicants.length,
                  itemBuilder: (context, index) {
                    final app = applicants[index];
                    final detail = app['detail'] ?? {};
                    final job = app['job'] ?? {};
                    
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
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
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: app['status'] == 'pending' ? Colors.orange.withOpacity(0.1) : (app['status'] == 'accepted' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1)),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      app['status']?.toString().toUpperCase() ?? 'PENDING',
                                      style: TextStyle(
                                        color: app['status'] == 'pending' ? Colors.orange : (app['status'] == 'accepted' ? Colors.green : Colors.red),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const Divider(height: 24),
                            _buildInfoRow(Icons.person, detail['username']?.toString() ?? 'Tanpa Nama'),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.email, detail['user_email']?.toString() ?? 'Tidak ada email'),
                            const SizedBox(height: 8),
                            _buildInfoRow(Icons.phone, detail['phone_number']?.toString() ?? 'Tidak ada No HP'),
                            const SizedBox(height: 8),
                            _buildCVRow(detail['cv']?.toString()),
                            if (app['status'] == 'pending') ...[
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () => _updateStatus(app['id'].toString(), 'accepted'),
                                      child: const Text('Terima'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () => _updateStatus(app['id'].toString(), 'rejected'),
                                      child: const Text('Tolak'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  Widget _buildCVRow(String? cvPath) {
    if (cvPath == null || cvPath.isEmpty) {
      return _buildInfoRow(Icons.description, 'Tidak ada CV');
    }
    
    return Row(
      children: [
        Icon(Icons.description, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 8),
        Expanded(
          child: InkWell(
            onTap: () async {
              final url = Uri.parse('http://127.0.0.1:8000/storage/$cvPath');
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Tidak dapat membuka file CV')),
                  );
                }
              }
            },
            child: const Text(
              'Lihat CV (PDF)',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xFF6F42C1),
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
