import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsi1apb/screens/company/company_profile.dart';
import 'package:responsi1apb/screens/company/company_job_create.dart';
import 'package:responsi1apb/screens/company/company_job_list.dart';
import 'package:responsi1apb/screens/company/company_applicants_list.dart';
import 'package:responsi1apb/screens/auth/signin.dart';

class CompanyDashboard extends StatefulWidget {
  const CompanyDashboard({super.key});

  @override
  State<CompanyDashboard> createState() => _CompanyDashboardState();
}

class _CompanyDashboardState extends State<CompanyDashboard> {
  String userName = '';
  final Color primaryColor = const Color(0xFF6F42C1);

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? 'Perusahaan';
    });
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    if (!mounted) return;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FB),
      body: Column(
        children: [
          _buildTopHeader(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Menu Utama',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E006B),
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildMenuCard(
                    icon: Icons.business,
                    title: 'Profil Perusahaan',
                    subtitle: 'Lengkapi data perusahaan Anda',
                    color: const Color(0xFF6F42C1),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CompanyProfilePage()));
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuCard(
                    icon: Icons.post_add,
                    title: 'Buat Lowongan',
                    subtitle: 'Posting lowongan kerja baru',
                    color: const Color(0xFF4CA1AF),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CompanyJobCreatePage()));
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuCard(
                    icon: Icons.list_alt,
                    title: 'Daftar Lowongan',
                    subtitle: 'Kelola status lowongan (Buka/Tutup)',
                    color: const Color(0xFFF39C12),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CompanyJobList()));
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildMenuCard(
                    icon: Icons.people_alt_rounded,
                    title: 'Daftar Pelamar',
                    subtitle: 'Lihat siapa saja yang melamar',
                    color: const Color(0xFFE74C3C),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CompanyApplicantsList()));
                    },
                  ),
                ],
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
      padding: const EdgeInsets.fromLTRB(26, 64, 26, 30),
      decoration: const BoxDecoration(
        color: Color(0xFF2E006B),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(34),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Company Dashboard',
                style: TextStyle(color: Colors.white70, fontSize: 15),
              ),
              IconButton(
                onPressed: _logout,
                icon: const Icon(Icons.logout, color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 8),
          Text(
            userName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF212529),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF8E8E93),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Color(0xFFCFCFCF), size: 18),
          ],
        ),
      ),
    );
  }
}
