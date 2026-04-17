import 'package:flutter/material.dart';
import 'package:responsi1apb/rangga/signin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JobieRoleScreen(),
    );
  }
}

class JobieRoleScreen extends StatelessWidget {
  const JobieRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA), // Warna background abu-abu sangat muda
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              
              // Logo 'J'
              Container(
                width: 100,
                height: 100,
                decoration: const BoxDecoration(
                  color: Color(0xFF6B33DF), // Ungu Jobie
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'J',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Teks Judul Aplikasi
              const Text(
                'Jobie',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: Color(0xFF1E212D), // Warna hitam gelap
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),

              // Subjudul Aplikasi
              const Text(
                'Job Portal iOS App',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF888C99), // Abu-abu
                  fontWeight: FontWeight.w500,
                ),
              ),
              
              const SizedBox(height: 60),

              // Bagian "Continue as"
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Continue as',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E212D),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Lorem ipsum dolor sit amet, consectetur\nadipiscing elit, sed do eiusmod tempor',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF888C99),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Card Job Seekers
                    RoleOptionCard(
                      title: 'JOB SEEKERS',
                      description: 'Finding a job here never\nbeen easier than before',
                      iconData: Icons.person, // Ganti dengan Image.asset jika ada gambarnya
                      iconColor: const Color(0xFFFFAE88),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 16),

                    // Card Company
                    RoleOptionCard(
                      title: 'COMPANY',
                      description: "Let's recruit your great\ncandidate faster here",
                      iconData: Icons.business_center, // Ganti dengan Image.asset jika ada gambarnya
                      iconColor: const Color(0xFFD6A986),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget Reusable untuk Card Pilihan
class RoleOptionCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData iconData;
  final Color iconColor;
  final VoidCallback onTap;

  const RoleOptionCard({
    super.key,
    required this.title,
    required this.description,
    required this.iconData,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFE5E7EB), // Warna border abu-abu terang
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Placeholder untuk Avatar Ilustrasi
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                color: iconColor,
                size: 32,
              ),
            ),
            const SizedBox(width: 20),
            
            // Teks Title & Description
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6B33DF), // Ungu sesuai desain
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF888C99),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}