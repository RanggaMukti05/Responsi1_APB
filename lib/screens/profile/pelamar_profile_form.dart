import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PelamarProfileForm extends StatefulWidget {
  final Map<String, dynamic>? initialData;
  final bool isEdit;

  const PelamarProfileForm({
    super.key,
    this.initialData,
    this.isEdit = false,
  });

  @override
  State<PelamarProfileForm> createState() => _PelamarProfileFormState();
}

class _PelamarProfileFormState extends State<PelamarProfileForm> {
  final TextEditingController _umurController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      _umurController.text = widget.initialData!['umur']?.toString() ?? '';
      _alamatController.text = widget.initialData!['alamat']?.toString() ?? '';
      _noHpController.text = widget.initialData!['no_hp']?.toString() ?? '';
      _tanggalLahirController.text = widget.initialData!['tanggal_lahir']?.toString() ?? '';
    }
  }

  @override
  void dispose() {
    _umurController.dispose();
    _alamatController.dispose();
    _noHpController.dispose();
    _tanggalLahirController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)), // Default 20 tahun lalu
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _tanggalLahirController.text = "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> _submitForm() async {
    if (_umurController.text.isEmpty ||
        _tanggalLahirController.text.isEmpty ||
        _alamatController.text.isEmpty ||
        _noHpController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap lengkapi semua data')),
      );
      return;
    }

    setState(() => _isLoading = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('auth_token');

    final url = Uri.parse('http://127.0.0.1:8000/api/pelamar');
    
    // Jika isEdit true, artinya profil sudah dibuat di backend (entah kosong atau terisi), jadi gunakan PUT
    // Tapi karena backend kita sudah otomatis membuat pelamar di register/apply, kita bisa mencoba POST lalu fallback ke PUT
    // Atau lebih aman langsung PUT jika kita yakin tabel pelamarnya sudah ada atau akan ditangani backend.
    // Di backend, update() menggunakan PUT.
    // Kita gunakan PUT saja secara default karena pelamar auto-created.
    
    try {
      final response = await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'umur': int.tryParse(_umurController.text) ?? 0,
          'tanggal_lahir': _tanggalLahirController.text,
          'alamat': _alamatController.text,
          'no_hp': _noHpController.text,
        }),
      );

      // Jika PUT gagal (kemungkinan karena data belum ada), coba POST
      if (response.statusCode == 404) {
        final postResponse = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
            'Content-Type': 'application/json',
          },
          body: json.encode({
            'umur': int.tryParse(_umurController.text) ?? 0,
            'tanggal_lahir': _tanggalLahirController.text,
            'alamat': _alamatController.text,
            'no_hp': _noHpController.text,
          }),
        );
        
        if (postResponse.statusCode == 200 || postResponse.statusCode == 201) {
          _successSubmit();
          return;
        } else {
          _handleError(postResponse.body);
          return;
        }
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        _successSubmit();
      } else {
        _handleError(response.body);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  void _successSubmit() {
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profil berhasil disimpan!')),
    );
    Navigator.pop(context, true); // Return true to refresh parent
  }

  void _handleError(String responseBody) {
    setState(() => _isLoading = false);
    final data = json.decode(responseBody);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(data['message'] ?? 'Gagal menyimpan profil')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF6F42C1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lengkapi Profil Pelamar'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Detail Pelamar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Silakan lengkapi data diri Anda untuk memudahkan melamar pekerjaan.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),
            _buildTextField(
              controller: _umurController,
              label: 'Umur (Tahun)',
              icon: Icons.cake,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            InkWell(
              onTap: () => _selectDate(context),
              child: IgnorePointer(
                child: _buildTextField(
                  controller: _tanggalLahirController,
                  label: 'Tanggal Lahir (YYYY-MM-DD)',
                  icon: Icons.calendar_today,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _noHpController,
              label: 'Nomor Handphone',
              icon: Icons.phone,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _alamatController,
              label: 'Alamat Lengkap',
              icon: Icons.location_on,
              maxLines: 3,
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 50,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Simpan Profil',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF6F42C1)),
        ),
      ),
    );
  }
}
