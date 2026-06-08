import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyJobCreatePage extends StatefulWidget {
  const CompanyJobCreatePage({super.key});

  @override
  State<CompanyJobCreatePage> createState() => _CompanyJobCreatePageState();
}

class _CompanyJobCreatePageState extends State<CompanyJobCreatePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController reqController = TextEditingController();

  bool isSubmitting = false;

  final Color primaryColor = const Color(0xFF6F42C1);
  final Color bgColor = const Color(0xFFF9F9FB);

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    reqController.dispose();
    super.dispose();
  }

  Future<void> _submitJob() async {
    if (titleController.text.isEmpty || descController.text.isEmpty || reqController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Harap isi semua kolom')));
      return;
    }

    setState(() => isSubmitting = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('auth_token') ?? '';

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/jobs'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'title': titleController.text,
          'description': descController.text,
          'requirements': reqController.text,
        }),
      );

      final resData = jsonDecode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lowongan berhasil dibuat!')));
        Navigator.pop(context);
      } else {
        if (!mounted) return;
        // Tangani pesan "Anda harus melengkapi profil perusahaan terlebih dahulu." dengan kode 403
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(resData['message'] ?? 'Gagal membuat lowongan')));
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    } finally {
      if (mounted) {
        setState(() => isSubmitting = false);
      }
    }
  }

  Widget _buildTextField(String label, TextEditingController controller, {int maxLines = 1, String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2E006B),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: primaryColor),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text('Buat Lowongan', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text(
              'Detail lowongan pekerjaan yang akan Anda posting akan terlihat oleh pelamar.',
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            const SizedBox(height: 30),
            _buildTextField('Posisi Pekerjaan (Title)', titleController, hint: 'Contoh: Software Engineer'),
            _buildTextField('Deskripsi Pekerjaan', descController, maxLines: 4, hint: 'Jelaskan tentang posisi ini...'),
            _buildTextField('Kualifikasi / Persyaratan', reqController, maxLines: 4, hint: 'Pisahkan dengan enter...'),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: isSubmitting ? null : _submitJob,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: isSubmitting
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Posting Lowongan',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
