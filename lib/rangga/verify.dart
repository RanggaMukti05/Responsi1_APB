import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsi1apb/rangga/createakun.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: OtpVerifyScreen(),
    );
  }
}

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({super.key});

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  // Membuat list untuk menyimpan controller dan focus node untuk 6 kotak OTP
  final List<TextEditingController> _controllers = List.generate(6, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (index) => FocusNode());

  @override
  void dispose() {
    // Pastikan untuk menghapus controller dan focus node dari memori saat layar ditutup
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB), // Background abu-abu terang
      
      // Tombol Create Account di paling bawah layar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F9FB),
          border: Border(
            top: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
          ),
        ),
        child: SizedBox(
          height: 55,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => SignUpScreen(),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEAE2FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Create account',
              style: TextStyle(
                color: Color(0xFF7033FF),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      
      body: SingleChildScrollView(
        child: Stack(
          children: [
            // 1. Background Ungu (Header)
            Container(
              height: 200,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF8A4DFF), 
                    Color(0xFF7033FF), 
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
            ),
            
            // Elemen Dekoratif Lengkungan
            Positioned(
              right: -60,
              bottom: -40,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),

            // 2. Konten Utama
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    
                    // Teks Judul
                    const Text(
                      'OTP Verify',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    
                    // Teks Subjudul
                    const Text(
                      'Please enter your OTP',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    
                    const SizedBox(height: 40),

                    // Baris Kotak OTP
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) => _buildOtpBox(index)),
                    ),
                    
                    const SizedBox(height: 30),

                    // Tombol Verify & Proceed
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          // Menggabungkan semua teks dari kotak menjadi satu string OTP
                          String otpCode = _controllers.map((c) => c.text).join();
                          print("OTP yang dimasukkan: $otpCode");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF7033FF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Verify & Proceed',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi khusus untuk membuat masing-masing kotak OTP
  Widget _buildOtpBox(int index) {
    return SizedBox(
      width: 48, // Lebar masing-masing kotak
      height: 55, // Tinggi masing-masing kotak
      child: TextField(
        controller: _controllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1, // Maksimal 1 karakter per kotak
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly, // Hanya angka
        ],
        decoration: InputDecoration(
          counterText: "", // Menyembunyikan teks counter karakter bawaan (0/1)
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.zero,
          hintText: "-",
          hintStyle: const TextStyle(color: Color(0xFFD1D5DB)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFF7033FF), width: 1.5), // Garis ungu saat aktif
          ),
        ),
        onChanged: (value) {
          // LOGIKA PINDAH KOTAK OTOMATIS
          if (value.isNotEmpty) {
            // Jika ada isinya dan bukan kotak terakhir, pindah ke kanan
            if (index < 5) {
              FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
            } else {
              // Jika ini kotak terakhir dan sudah diisi, tutup keyboard
              FocusScope.of(context).unfocus(); 
            }
          } else {
            // Jika dihapus (kosong) dan bukan kotak pertama, pindah ke kiri
            if (index > 0) {
              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
            }
          }
        },
      ),
    );
  }
}