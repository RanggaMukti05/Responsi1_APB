import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ApplyJobPage extends StatefulWidget {
  final String jobId;
  final String companyName;
  final String jobTitle;
  final String logoPath;

  const ApplyJobPage({
    super.key,
    required this.jobId,
    required this.companyName,
    required this.jobTitle,
    required this.logoPath,
  });

  @override
  State<ApplyJobPage> createState() => _ApplyJobPageState();
}

class _ApplyJobPageState extends State<ApplyJobPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  PlatformFile? cvFile;
  bool isSubmitting = false;

  final Color primaryColor = const Color(0xFF6F42C1);
  final Color darkHeaderColor = const Color(0xFF2E006B);
  final Color bgColor = const Color(0xFFF6F6F6);
  final Color borderColor = const Color(0xFFD9D9D9);
  final Color hintColor = const Color(0xFF8E8E93);
  final Color titleColor = const Color(0xFF212529);

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> _submitApply() async {
    if (nameController.text.isEmpty || emailController.text.isEmpty || phoneController.text.isEmpty || cvFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Harap isi semua data dan upload CV')));
      return;
    }

    setState(() => isSubmitting = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('auth_token') ?? '';

    try {
      // 1. Buat application dulu
      final appRes = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/applications'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'company_job_id': widget.jobId}),
      );

      final appData = jsonDecode(appRes.body);
      if (appRes.statusCode != 201 && appRes.statusCode != 200) {
        setState(() => isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(appData['message'] ?? 'Gagal membuat lamaran')));
        return;
      }

      String appId = appData['data']['id'].toString();

      // 2. Buat detail application dengan multipart request
      var request = http.MultipartRequest('POST', Uri.parse('http://127.0.0.1:8000/api/detail-applications'));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      
      request.fields['application_id'] = appId;
      request.fields['username'] = nameController.text;
      request.fields['user_email'] = emailController.text;
      request.fields['phone_number'] = phoneController.text;

      if (cvFile!.bytes != null) {
        request.files.add(http.MultipartFile.fromBytes('cv', cvFile!.bytes!, filename: cvFile!.name));
      } else if (cvFile!.path != null) {
        request.files.add(await http.MultipartFile.fromPath('cv', cvFile!.path!));
      }

      var response = await request.send();
      if (response.statusCode == 201 || response.statusCode == 200) {
        setState(() => isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Lamaran berhasil dikirim!')));
        Navigator.pop(context); // Kembali ke halaman sebelumnya
      } else {
        setState(() => isSubmitting = false);
        var resBody = await response.stream.bytesToString();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal mengirim detail lamaran: $resBody')));
      }
    } catch (e) {
      setState(() => isSubmitting = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Terjadi kesalahan: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        children: [
          _buildTopHeader(),
          Expanded(
            child: Transform.translate(
              offset: const Offset(0, -18),
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(34),
                  ),
                ),
                child: Column(
                  children: [
                    _buildApplyHeader(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                        child: Column(
                          children: [
                            _buildUploadResumeBox(),
                            const SizedBox(height: 28),
                            _buildInputField(
                              controller: nameController,
                              hintText: 'User name',
                            ),
                            const SizedBox(height: 18),
                            _buildInputField(
                              controller: emailController,
                              hintText: 'User email',
                            ),
                            const SizedBox(height: 18),
                            _buildInputField(
                              controller: phoneController,
                              hintText: 'Phone number',
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                    _buildBottomButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(26, 64, 26, 54),
      decoration: BoxDecoration(
        color: darkHeaderColor,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.companyName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  widget.jobTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    height: 1.25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              widget.logoPath,
              width: 116,
              height: 116,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 116,
                  height: 116,
                  color: Colors.blue,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: Colors.white,
                    size: 34,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildApplyHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 24, 18, 18),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(34),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            borderRadius: BorderRadius.circular(30),
            child: const Padding(
              padding: EdgeInsets.all(6),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color(0xFFA0A0A0),
                size: 30,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Apply',
            style: TextStyle(
              color: titleColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadResumeBox() {
    return GestureDetector(
      onTap: () async {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );
        if (result != null) {
          setState(() {
            cvFile = result.files.first;
          });
        }
      },
      child: Container(
        width: double.infinity,
        height: 86,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(44),
          border: Border.all(
            color: const Color(0xFFCFCFCF),
            width: 1.6,
            strokeAlign: BorderSide.strokeAlignInside,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              cvFile != null ? cvFile!.name : '+ Upload Resume',
              style: TextStyle(
                color: cvFile != null ? titleColor : hintColor,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        border: Border.all(color: borderColor),
        color: Colors.white,
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: titleColor,
          fontSize: 17,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: hintColor,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 26,
            vertical: 22,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
      decoration: const BoxDecoration(
        color: Color(0xFFF7F7F7),
        border: Border(
          top: BorderSide(
            color: Color(0xFFE2E2E2),
          ),
        ),
      ),
      child: SizedBox(
        height: 64,
        child: ElevatedButton(
          onPressed: isSubmitting ? null : _submitApply,
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(34),
            ),
          ),
          child: isSubmitting 
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  'Apply job',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}