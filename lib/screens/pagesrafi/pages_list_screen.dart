import 'package:flutter/material.dart';
import 'package:responsi1apb/screens/dashboard/dashboard.dart';
import 'package:responsi1apb/screens/auth/loginjob.dart';
import 'package:responsi1apb/screens/auth/signin.dart';
import 'package:responsi1apb/screens/auth/forgetpw.dart';
import 'package:responsi1apb/screens/auth/verify.dart';
import 'package:responsi1apb/screens/auth/createakun.dart';
import 'package:responsi1apb/screens/profile/profil_page.dart';
import 'package:responsi1apb/screens/profile/apply_job.dart';
import 'package:responsi1apb/screens/profile/company_details_page.dart';
import 'package:responsi1apb/screens/profile/detail_job.dart';
import 'package:responsi1apb/screens/profile/chat_page.dart';
import 'package:responsi1apb/screens/profile/chat_room_page.dart';
import 'package:responsi1apb/screens/pages/notification_page.dart';
import 'package:responsi1apb/screens/onboarding/splash_screen.dart';
import 'package:responsi1apb/screens/dashboard/kategori_page.dart';
import 'package:responsi1apb/main.dart'; // Import ini penting untuk tema
import 'package:responsi1apb/screens/onboarding/get_started.dart';
import 'package:responsi1apb/screens/pages/components_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PagesListScreen(),
    );
  }
}

class PagesListScreen extends StatefulWidget {
  const PagesListScreen({super.key});

  @override
  State<PagesListScreen> createState() => _PagesListScreenState();
}

class _PagesListScreenState extends State<PagesListScreen> {
  // Key untuk mengontrol pembukaan sidebar
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Index aktif di Bottom Navigation (1 = Pages)
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    // Data list menu (Sesuai kode awal kamu)
    final List<Map<String, dynamic>> menuItems = [
      {
        'title': 'Home',
        'icon': Icons.home_rounded,
        'color': Colors.teal,
        'destination': const JobieDashboard(),
      },
      {
        'title': 'Welcome',
        'icon': Icons.stars_rounded,
        'color': Colors.blue.shade300,
        'destination': const JobieRoleScreen(),
      },
      {
        'title': 'Profile',
        'icon': Icons.person_rounded,
        'color': Colors.redAccent,
        'destination': const ProfilePage(),
      },
      {
        'title': 'Apply Form',
        'icon': Icons.assignment_rounded,
        'color': Colors.orangeAccent,
        'destination': const ApplyJobPage(
          companyName: 'PT Telkom Indonesia',
          jobTitle: 'System Analyst',
          logoPath: 'assets/images/job.jpeg',
        ),
      },
      {
        'title': 'Company Detail',
        'icon': Icons.business_rounded,
        'color': Colors.deepOrangeAccent,
        'destination': const CompanyDetailsPage(
          companyName: 'PT. Telkom Indoensia',
          logoPath: 'assets/images/job.jpeg',
        ),
      },
      {
        'title': 'Job Detail',
        'icon': Icons.work_rounded,
        'color': Colors.pinkAccent,
        'destination': const DetailJobPage(
          companyName: 'PT. Telkom Indonesia',
          jobTitle: 'Programmer Full Stack',
          salary: 'Rp 20.000.000',
          location: 'Yogyakarta',
          logoPath: 'assets/images/job.jpeg',
        ),
      },
      {
        'title': 'Login',
        'icon': Icons.login_rounded,
        'color': Colors.lightBlueAccent,
        'destination': const SignInScreen(),
      },
      {
        'title': 'Forgot Password',
        'icon': Icons.lock_rounded,
        'color': Colors.pink.shade300,
        'destination': const ForgotPasswordScreen(),
      },
      {
        'title': 'OTP Confirm',
        'icon': Icons.verified_user_rounded,
        'color': Colors.pink.shade200,
        'destination': const OtpVerifyScreen(),
      },
      {
        'title': 'Messages List',
        'icon': Icons.tune_rounded,
        'color': Colors.redAccent,
        'destination': const ChatPage(),
      },
      {
        'title': 'Messages',
        'icon': Icons.messenger_rounded,
        'color': Colors.blueAccent,
        'destination': const ChatRoomPage(
          userName: 'Ibnu Jamil',
          userImage: 'assets/images/logo_abu.png',
        ),
      },
      {
        'title': 'Notification',
        'icon': Icons.notifications_rounded,
        'color': Colors.tealAccent.shade700,
        'destination': const NotificationPage(),
      },
      {
        'title': 'Onboarding',
        'icon': Icons.pie_chart_rounded,
        'color': Colors.amber,
        'destination': const SplashScreen(),
      },
      {
        'title': 'Register',
        'icon': Icons.person_add_rounded,
        'color': Colors.orange.shade300,
        'destination': const SignUpScreen(),
      },
      {
        'title': 'Search',
        'icon': Icons.search_rounded,
        'color': Colors.purpleAccent,
        'destination': const KategoriPage(),
      },
      {
        'title': 'Error Page',
        'icon': Icons.dangerous_rounded,
        'color': Colors.red.shade400,
      },
    ];

    // Membungkus dengan ValueListenableBuilder untuk mendukung perubahan tema
    return ValueListenableBuilder<Color>(
      valueListenable: colorNotifier,
      builder: (context, primaryColor, _) {
        final textColor =
            Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
        final bgColor = Theme.of(context).scaffoldBackgroundColor;

        return Scaffold(
          key: _scaffoldKey, // Key untuk memanggil sidebar
          backgroundColor: bgColor,
          drawer: _buildSidebar(primaryColor), // Menambahkan sidebar
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.grey.shade400,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Pages',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.grid_view_rounded,
                  color: Colors.grey.shade400,
                ),
                onPressed: () {
                  // Membuka sidebar saat ikon di kanan atas ditekan
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
            ],
          ),

          body: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            itemCount: menuItems.length,
            separatorBuilder: (context, index) =>
                Divider(height: 1, color: Theme.of(context).dividerColor),
            itemBuilder: (context, index) {
              final item = menuItems[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: item['color'].withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item['icon'], color: item['color'], size: 24),
                ),
                title: Text(
                  item['title'],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor, // Menggunakan warna teks sesuai tema
                  ),
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.grey.shade300,
                  size: 16,
                ),
                onTap: () {
                  if (item.containsKey('destination') &&
                      item['destination'] != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => item['destination'],
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Halaman ${item['title']} belum dibuat.'),
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  }
                },
              );
            },
          ),
          bottomNavigationBar: _buildBottomNav(
            primaryColor,
          ),
        );
      },
    );
  }

  Widget _buildBottomNav(Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          if (index == 3) {
            _scaffoldKey.currentState?.openDrawer();
          } else if (index == 0) {
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 2) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const ChatPage()),
            );
          } else {
            setState(() => _currentIndex = index);
          }
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: const Color(0xFFa19fa8),
        backgroundColor: Theme.of(context).cardColor,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 28),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded, size: 26),
            label: "Pages",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline_rounded, size: 26),
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_rounded, size: 26),
            label: "Menu",
          ),
        ],
      ),
    );
  }

  // WIDGET SIDEBAR
  Widget _buildSidebar(Color primaryColor) {
    return Drawer(
      child: Container(
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              decoration: const BoxDecoration(color: Color(0xFF4DA3F0)),
              child: Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      'https://i.pravatar.cc/150?img=11',
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 56,
                        height: 56,
                        color: Colors.grey.shade400,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Good Morning',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Henry Kanwil',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MAIN MENU',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _drawerItem(
                      Icons.favorite_rounded,
                      const Color(0xFFFF6F91),
                      const Color(0xFFFFEEF2),
                      'Welcome',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const JobieRoleScreen(),
                          ),
                        );
                      },
                    ),
                    _drawerItem(
                      Icons.home_rounded,
                      const Color(0xFFFF66B3),
                      const Color(0xFFFFEEF7),
                      'Home',
                      onTap: () {
                        Navigator.popUntil(context, (route) => route.isFirst);
                      },
                    ),
                    _drawerItem(
                      Icons.layers_rounded,
                      const Color(0xFFFFA14A),
                      const Color(0xFFFFF4E7),
                      'Pages',
                      onTap: () {
                        Navigator.pop(
                          context,
                        ); // Tutup drawer, karena sudah di Pages
                      },
                    ),
                    _drawerItem(
                      Icons.grid_view_rounded,
                      const Color(0xFF47B5FF),
                      const Color(0xFFEAF7FF),
                      'Components',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ComponentsPage(),
                          ),
                        );
                      },
                    ),
                    _drawerItem(
                      Icons.notifications_rounded,
                      const Color(0xFF19B38C),
                      const Color(0xFFE8FAF4),
                      'Notification',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationPage(),
                          ),
                        );
                      },
                    ),
                    _drawerItem(
                      Icons.person_rounded,
                      const Color(0xFFE3B100),
                      const Color(0xFFFFF7DD),
                      'Profile',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfilePage(),
                          ),
                        );
                      },
                    ),
                    _drawerItem(
                      Icons.chat_bubble_rounded,
                      const Color(0xFF56C3EA),
                      const Color(0xFFEAF9FF),
                      'Chat',
                      badge: '5',
                      badgeColor: const Color(0xFF56C3EA),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatPage(),
                          ),
                        );
                      },
                    ),
                    _drawerItem(
                      Icons.logout_rounded,
                      const Color(0xFFFF7A9C),
                      const Color(0xFFFFEEF2),
                      'Logout',
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GetStartedScreen(),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Text(
                      'SETTINGS',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _drawerItem(
                      Icons.palette_rounded,
                      const Color(0xFF5D8BFF),
                      const Color(0xFFEEF3FF),
                      'Highlights',
                      onTap: () {
                        Navigator.pop(context);
                        // Fitur ganti warna tidak disertakan di file ini agar ringkas
                        // Jika butuh, _showColorPicker() bisa disalin dari dashboard.dart
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8FAF4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.nightlight_round,
                              color: Color(0xFF0FA37F),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Text(
                              'Dark Mode',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(
                                  context,
                                ).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ),
                          ValueListenableBuilder<ThemeMode>(
                            valueListenable: themeNotifier,
                            builder: (context, currentMode, _) {
                              return Switch(
                                value: currentMode == ThemeMode.dark,
                                onChanged: (val) => themeNotifier.value = val
                                    ? ThemeMode.dark
                                    : ThemeMode.light,
                                activeColor: Colors.white,
                                activeTrackColor: primaryColor,
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
          ],
        ),
      ),
    );
  }

  // WIDGET ITEM MENU SIDEBAR
  Widget _drawerItem(
    IconData icon,
    Color iconColor,
    Color boxColor,
    String title, {
    String? badge,
    Color? badgeColor,
    VoidCallback? onTap,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: boxColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badge != null)
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: badgeColor,
                shape: BoxShape.circle,
              ),
              child: Text(
                badge,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }
} // <-- Penutup akhir class _PagesListScreenState
