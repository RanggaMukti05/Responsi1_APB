import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsi1apb/main.dart';
import 'package:responsi1apb/screens/profile/profil_page.dart';
import 'package:responsi1apb/screens/job/detail_job.dart';
import 'package:responsi1apb/screens/dashboard/kategori_page.dart';
import 'package:responsi1apb/screens/auth/signin.dart';
import 'package:responsi1apb/screens/onboarding/get_started.dart';
import 'package:responsi1apb/screens/auth/loginjob.dart';
import 'package:responsi1apb/screens/pages/components_page.dart';
import 'package:responsi1apb/screens/models/component_model.dart';
import 'package:responsi1apb/screens/pages/notification_page.dart';
import 'package:responsi1apb/screens/models/notification_model.dart';
import 'package:responsi1apb/screens/pagesrafi/pages_list_screen.dart';
import 'package:responsi1apb/screens/profile/profil_page.dart';
import 'package:responsi1apb/screens/profile/chat_page.dart';

class JobieDashboard extends StatefulWidget {
  const JobieDashboard({Key? key}) : super(key: key);

  @override
  State<JobieDashboard> createState() => _JobieDashboardState();
}

class _JobieDashboardState extends State<JobieDashboard> {
  int _currentIndex = 0;
  int _currentRecommendedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController searchController = TextEditingController();
  final PageController _pageController = PageController(viewportFraction: 0.88);

  // DATA LIST PEKERJAAN (Sekarang ada 3 data)
  final List<Map<String, String>> allJobs = [
    {
      'title': 'Software Engineer',
      'company': 'Highspeed Studios',
      'location': 'Jakarta, Indonesia',
      'salary': '\$500 - \$1,000',
      'logo': 'assets/images/logo/logo_oren.png',
    },
    {
      'title': 'Database Engineer',
      'company': 'Lunar Djaja Corp.',
      'location': 'London, United Kingdom',
      'salary': '\$500 - \$1,000',
      'logo': 'assets/images/logo/logo_ungu.png',
    },
    {
      'title': 'Software Engineer',
      'company': 'Highspeed Studios',
      'location': 'Medan, Indonesia',
      'salary': '\$500 - \$1,000',
      'logo': 'assets/images/logo/logo_abu.png',
    },
  ];

  final List<Map<String, dynamic>> themeColors = [
    {'name': 'Default', 'color': const Color(0xFF6F42C1)},
    {'name': 'Green', 'color': const Color(0xFF28A745)},
    {'name': 'Blue', 'color': const Color(0xFF007BFF)},
    {'name': 'Pink', 'color': const Color(0xFFE83E8C)},
    {'name': 'Yellow', 'color': const Color(0xFFFFC107)},
    {'name': 'Orange', 'color': const Color(0xFFFD7E14)},
    {'name': 'Purple', 'color': const Color(0xFF9C27B0)},
    {'name': 'Red', 'color': const Color(0xFFDC3545)},
    {'name': 'Lightblue', 'color': const Color(0xFF17A2B8)},
    {'name': 'Teal', 'color': const Color(0xFF20C997)},
    {'name': 'Lime', 'color': const Color(0xFFA4C639)},
    {'name': 'Deeporange', 'color': const Color(0xFFFF5722)},
  ];

  // FUNGSI UNTUK SEARCH PEKERJAAN
  List<Map<String, String>> get filteredJobs {
    final searchText = searchController.text.toLowerCase().trim();
    return allJobs.where((job) {
      return searchText.isEmpty ||
          job['title']!.toLowerCase().contains(searchText) ||
          job['company']!.toLowerCase().contains(searchText) ||
          job['location']!.toLowerCase().contains(searchText);
    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _showColorPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(top: 36, left: 24, right: 24),
          height: 420,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 24,
              childAspectRatio: 0.85,
            ),
            itemCount: themeColors.length,
            itemBuilder: (context, index) {
              final item = themeColors[index];
              return GestureDetector(
                onTap: () {
                  colorNotifier.value = item['color'];
                  Navigator.pop(context);
                },
                child: Column(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: item['color'],
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item['name'],
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF8E8E93),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Color>(
      valueListenable: colorNotifier,
      builder: (context, primaryColor, _) {
        return Scaffold(
          key: _scaffoldKey,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          drawer: _buildSidebar(primaryColor),
          body: IndexedStack(
            index: _currentIndex,
            children: [
              _buildHomeTab(primaryColor),
              const Center(child: Text("Pages Content")),
              const Center(child: Text("Chat Content")),
              const ProfilePage(),
            ],
          ),
          bottomNavigationBar: _buildBottomNav(primaryColor),
        );
      },
    );
  }

  Widget _buildHomeTab(Color primaryColor) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildTopHeader(primaryColor),
            Transform.translate(
              offset: const Offset(0, -34),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    _buildSearchBar(),
                    const SizedBox(height: 20),
                    _buildStats(primaryColor),
                  ],
                ),
              ),
            ),
            _buildCategories(primaryColor),
            const SizedBox(height: 30),
            _buildRecommendedSection(primaryColor),
            const SizedBox(height: 30),
            _buildRecentSection(primaryColor),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTopHeader(Color primaryColor) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 60),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.grid_view_rounded,
                  color: Colors.white,
                  size: 28,
                ),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: _showColorPicker,
                    child: const Icon(
                      Icons.palette_outlined,
                      color: Colors.white,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 15),
                  ValueListenableBuilder<ThemeMode>(
                    valueListenable: themeNotifier,
                    builder: (context, currentMode, _) {
                      return GestureDetector(
                        onTap: () {
                          themeNotifier.value = currentMode == ThemeMode.light
                              ? ThemeMode.dark
                              : ThemeMode.light;
                        },
                        child: Icon(
                          currentMode == ThemeMode.dark
                              ? Icons.light_mode
                              : Icons.nightlight_round,
                          color: Colors.white,
                          size: 26,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Good Morning",
                        style: TextStyle(color: Colors.white70, fontSize: 15),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Henry Kanwil",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                ClipOval(
                  child: Image.network(
                    'https://i.pravatar.cc/150?img=11',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 56,
                        height: 56,
                        color: Colors.grey.shade400,
                        child: const Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Color(0xFFB9B9B9), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              controller: searchController,
              onChanged: (value) =>
                  setState(() {}), // Memicu pencarian langsung saat ngetik
              decoration: const InputDecoration(
                hintText: "Search job here...",
                hintStyle: TextStyle(color: Color(0xFFB9B9B9), fontSize: 16),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStats(Color primaryColor) {
    return Row(
      children: [
        _statBox(primaryColor, Icons.work_outline, "29", "Jobs Applied"),
        const SizedBox(width: 16),
        _statBox(
          const Color(0xFF4DA3F0),
          Icons.person_outline,
          "3",
          "Interviews",
        ),
      ],
    );
  }

  Widget _statBox(Color color, IconData icon, String count, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 12),
            Text(
              count,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories(Color primaryColor) {
    final List<String> svgs = [
      'assets/icons/ikon petir.svg',
      'assets/icons/ikon pensil.svg',
      'assets/icons/ikon ekspand.svg',
      'assets/icons/ikon bintang.svg',
      'assets/icons/ikon kode.svg',
      'assets/icons/ikon profile user.svg',
      'assets/icons/ikon diagram pie.svg',
      'assets/icons/ikon tumpukan layer.svg',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Categories",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: svgs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigasi ke halaman Kategori
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KategoriPage(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Theme.of(context).dividerColor),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      svgs[index],
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRecommendedSection(Color primaryColor) {
    final textColor =
        Theme.of(context).textTheme.bodyMedium?.color ??
        const Color(0xFF8E8E93);

    final List<Map<String, String>> recommendedJobs = [
      {
        'title': 'Software Engineer',
        'loc': 'Jakarta, Indonesia',
        'sal': '\$500 - \$1,000',
        'logo': 'assets/images/logo/logo_hijau.png',
      },
      {
        'title': 'Data Analyst',
        'loc': 'Bandung, Indonesia',
        'sal': '\$400 - \$800',
        'logo': 'assets/images/logo/logo_hijau.png',
      },
      {
        'title': 'Product Manager',
        'loc': 'Surabaya, Indonesia',
        'sal': '\$600 - \$1,200',
        'logo': 'assets/images/logo/logo_hijau.png',
      },
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recomended Jobs",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: List.generate(
                  recommendedJobs.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 2),
                    width: _currentRecommendedIndex == index ? 24 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: _currentRecommendedIndex == index
                          ? primaryColor
                          : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentRecommendedIndex = index;
              });
            },
            itemCount: recommendedJobs.length,
            itemBuilder: (context, index) {
              final job = recommendedJobs[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Theme.of(context).dividerColor),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        job['logo']!,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            job['title']!,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            job['loc']!,
                            style: TextStyle(color: textColor, fontSize: 13),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.monetization_on_outlined,
                                color: primaryColor,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                job['sal']!,
                                style: TextStyle(
                                  color: textColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentSection(Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Recent Jobs",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
             GestureDetector(
                onTap: () {
                  // Navigasi ke KategoriPage saat teks "More" ditekan
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const KategoriPage(),
                    ),
                  );
                },
                child: Text(
                  "More",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // INI DIA KODENYA YANG OTOMATIS BACA DARI 'allJobs'
          filteredJobs.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      "Pekerjaan tidak ditemukan",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredJobs.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final job = filteredJobs[index];
                    return _recentJobCard(
                      primaryColor,
                      job['company']!,
                      job['title']!,
                      job['salary']!,
                      job['location']!,
                      job['logo']!,
                    );
                  },
                ),
        ],
      ),
    );
  }

  Widget _recentJobCard(
    Color primaryColor,
    String company,
    String title,
    String salary,
    String loc,
    String logo,
  ) {
    final textColor =
        Theme.of(context).textTheme.bodyMedium?.color ??
        const Color(0xFF8E8E93);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => DetailJobPage(
              companyName: company,
              jobTitle: title,
              salary: salary,
              location: loc,
              logoPath: logo,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                logo,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    company,
                    style: TextStyle(color: textColor, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.monetization_on_outlined,
                        color: primaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        salary,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: primaryColor,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        loc,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
                            builder: (context) => JobieRoleScreen(),
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
                        Navigator.pop(context);
                        setState(() => _currentIndex = 0);
                      },
                    ),
                    _drawerItem(
                      Icons.layers_rounded,
                      const Color(0xFFFFA14A),
                      const Color(0xFFFFF4E7),
                      'Pages',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PagesListScreen(),
                          ),
                        );
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
                            builder: (context) => ComponentsPage(),
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
                            builder: (context) => NotificationPage(),
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
                            builder: (context) => ProfilePage(),
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
                          MaterialPageRoute(builder: (context) => ChatPage()),
                        );
                      },
                    ),
                    _drawerItem(
                      Icons.logout_rounded,
                      const Color(0xFFFF7A9C),
                      const Color(0xFFFFEEF2),
                      'Logout',
                      onTap: () {
                        // Navigasi Logout: Pindah ke halaman Login dan hapus history halaman sebelumnya
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            // Ganti 'LoginScreen()' dengan nama class halaman loginmu (misal: JobieRoleScreen)
                            builder: (context) => GetStartedScreen(),
                          ),
                          (Route<dynamic> route) =>
                              false, // 'false' artinya hapus semua route/history sebelumnya
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
                        _showColorPicker();
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
}
