import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsi1apb/aldi/detail_job.dart';
import 'package:responsi1apb/aldi/profil_page.dart';

class JobieDashboard extends StatefulWidget {
  const JobieDashboard({Key? key}) : super(key: key);

  @override
  State<JobieDashboard> createState() => _JobieDashboardState();
}

class _JobieDashboardState extends State<JobieDashboard> {
  int _currentIndex = 0;

  final Color primaryColor = const Color(0xFF6F42C1);
  final Color secondaryColor = const Color(0xFF4DA3F0);
  final Color bgColor = const Color(0xFFF5F5F5);
  final Color borderColor = const Color(0xFFE4E4E4);
  final Color titleColor = const Color(0xFF212529);
  final Color textColor = const Color(0xFF8E8E93);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDarkMode = false;
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> allJobs = [
    {
      'title': 'Software Engineer',
      'company': 'Highspeed Studios',
      'location': 'Jakarta, Indonesia',
      'salary': '\$500 - \$1,000',
      'logo': 'assets/images/logo/logo_oren.png',
      'category': 'Developer',
    },
    {
      'title': 'Database Engineer',
      'company': 'Lunar Djaja Corp.',
      'location': 'London, United Kingdom',
      'salary': '\$500 - \$1,000',
      'logo': 'assets/images/logo/logo_ungu.png',
      'category': 'Data',
    },
    {
      'title': 'Software Engineer',
      'company': 'Highspeed Studios',
      'location': 'Medan, Indonesia',
      'salary': '\$900 - \$1,000',
      'logo': 'assets/images/logo/logo_abu.png',
      'category': 'Developer',
    },
  ];

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
    super.dispose();
  }

  void _goToDetailJob({
    required String companyName,
    required String jobTitle,
    required String salary,
    required String location,
    required String logoPath,
  }) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailJobPage(
          companyName: companyName,
          jobTitle: jobTitle,
          salary: salary,
          location: location,
          logoPath: logoPath,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recommendedJobs = filteredJobs.take(3).toList();

    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildAppDrawer(),
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              _buildHeader(),
              Transform.translate(
                offset: const Offset(0, -34),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      _buildSearchBar(),
                      const SizedBox(height: 20),
                      _buildFeaturesBox(),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCategories(),
                    const SizedBox(height: 30),
                    _buildRecommendedJobs(recommendedJobs),
                    const SizedBox(height: 26),
                    _buildRecentJobs(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildMenubarArea(),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 54),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF6F42C1),
            Color(0xFF9C6FE8),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(38),
          bottomRight: Radius.circular(38),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: const Icon(
                  Icons.grid_view_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              const Spacer(),
              const Icon(Icons.palette_outlined, color: Colors.white, size: 30),
              const SizedBox(width: 14),
              const Icon(Icons.nightlight_round, color: Colors.white, size: 30),
            ],
          ),
          const SizedBox(height: 34),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Good Morning',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Henry Kanwil',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 64,
                height: 64,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage('https://i.pravatar.cc/150?img=11'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(34),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        controller: searchController,
        onChanged: (_) => setState(() {}),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.search_rounded,
            color: Colors.grey.shade400,
            size: 34,
          ),
          hintText: 'Search job here...',
          hintStyle: TextStyle(
            color: Colors.grey.shade500,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 22),
        ),
      ),
    );
  }

  Widget _buildFeaturesBox() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 172,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.work_outline_rounded,
                    color: Colors.white, size: 34),
                const Spacer(),
                const Text(
                  '29',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Jobs Applied',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Container(
            height: 172,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.person_outline_rounded,
                    color: Colors.white, size: 34),
                const Spacer(),
                const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    fontWeight: FontWeight.w700,
                    height: 1,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Interviews',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    final List<String> iconFiles = [
      'assets/icons/ikon petir.svg',
      'assets/icons/ikon pensil.svg',
      'assets/icons/ikon ekspand.svg',
      'assets/icons/ikon bintang.svg',
      'assets/icons/ikon kode.svg',
      'assets/icons/ikon profile user.svg',
      'assets/icons/ikon diagram pie.svg',
      'assets/icons/ikon tumpukan layer.svg',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 18),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: iconFiles.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFE6E6E6)),
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconFiles[index],
                  width: 30,
                  height: 30,
                  colorFilter: ColorFilter.mode(
                    primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRecommendedJobs(List<Map<String, String>> recommendedJobs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Recomended Jobs',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: titleColor,
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  width: 48,
                  height: 8,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(width: 8),
                _dotIndicator(),
                const SizedBox(width: 8),
                _dotIndicator(),
              ],
            )
          ],
        ),
        const SizedBox(height: 18),
        SizedBox(
          height: 140,
          child: recommendedJobs.isEmpty
              ? Center(
            child: Text(
              'No jobs found',
              style: TextStyle(
                color: textColor,
                fontSize: 16,
              ),
            ),
          )
              : ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: recommendedJobs.length,
            separatorBuilder: (_, __) => const SizedBox(width: 18),
            itemBuilder: (context, index) {
              final job = recommendedJobs[index];

              return Container(
                width: 340,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE6E6E6)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset(
                        job['logo']!,
                        width: 90,
                        height: 90,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 90,
                            height: 90,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.broken_image),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job['title']!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: titleColor,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            job['location']!,
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Icon(
                                Icons.monetization_on_outlined,
                                color: primaryColor,
                                size: 28,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  job['salary']!,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRecentJobs() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Recent Jobs',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: titleColor,
                ),
              ),
            ),
            Text(
              'More',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: filteredJobs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final job = filteredJobs[index];

            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE6E6E6)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.asset(
                      job['logo']!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 100,
                          height: 100,
                          color: Colors.grey.shade300,
                          child: const Icon(Icons.broken_image),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            job['company']!,
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {
                              _goToDetailJob(
                                companyName: job['company']!,
                                jobTitle: job['title']!,
                                salary: job['salary']!,
                                location: job['location']!,
                                logoPath: job['logo']!,
                              );
                            },
                            child: Text(
                              job['title']!,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: titleColor,
                                height: 1.15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 14),
                          Row(
                            children: [
                              Icon(
                                Icons.monetization_on_outlined,
                                size: 28,
                                color: primaryColor,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  job['salary']!,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.work_outline_rounded,
                                size: 26,
                                color: primaryColor,
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  job['location']!,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: textColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _dotIndicator() {
    return Container(
      width: 14,
      height: 8,
      decoration: BoxDecoration(
        color: const Color(0xFFD4D4D4),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildAppDrawer() {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.82,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: SafeArea(
        child: Container(
          color: const Color(0xFFF7F7F7),
          child: Column(
            children: [
              _buildDrawerHeader(),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(22, 18, 22, 18),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'MAIN MENU',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Color(0xFF111111),
                        ),
                      ),
                      const SizedBox(height: 18),
                      _buildDrawerMenuItem(
                        icon: Icons.favorite_rounded,
                        iconColor: const Color(0xFFFF6F91),
                        boxColor: const Color(0xFFFFEEF2),
                        title: 'Welcome',
                      ),
                      _buildDrawerMenuItem(
                        icon: Icons.home_rounded,
                        iconColor: const Color(0xFFFF66B3),
                        boxColor: const Color(0xFFFFEEF7),
                        title: 'Home',
                      ),
                      _buildDrawerMenuItem(
                        icon: Icons.layers_rounded,
                        iconColor: const Color(0xFFFFA14A),
                        boxColor: const Color(0xFFFFF4E7),
                        title: 'Pages',
                      ),
                      _buildDrawerMenuItem(
                        icon: Icons.grid_view_rounded,
                        iconColor: const Color(0xFF47B5FF),
                        boxColor: const Color(0xFFEAF7FF),
                        title: 'Components',
                      ),
                      _buildDrawerMenuItem(
                        icon: Icons.notifications_rounded,
                        iconColor: const Color(0xFF19B38C),
                        boxColor: const Color(0xFFE8FAF4),
                        title: 'Notification',
                        badgeText: '1',
                        badgeColor: const Color(0xFFFF5C5C),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ProfilePage(),
                            ),
                          );
                        },
                        child: _buildDrawerMenuItem(
                          icon: Icons.person_rounded,
                          iconColor: const Color(0xFFE3B100),
                          boxColor: const Color(0xFFFFF7DD),
                          title: 'Profile',
                        ),
                      ),
                      _buildDrawerMenuItem(
                        icon: Icons.chat_bubble_rounded,
                        iconColor: const Color(0xFF56C3EA),
                        boxColor: const Color(0xFFEAF9FF),
                        title: 'Chat',
                        badgeText: '5',
                        badgeColor: const Color(0xFF56C3EA),
                      ),
                      _buildDrawerMenuItem(
                        icon: Icons.logout_rounded,
                        iconColor: const Color(0xFFFF7A9C),
                        boxColor: const Color(0xFFFFEEF2),
                        title: 'Logout',
                      ),
                      _buildDrawerMenuItem(
                        icon: Icons.phone_android_rounded,
                        iconColor: const Color(0xFFFF6C8C),
                        boxColor: const Color(0xFFFFEEF2),
                        title: 'One Level (Multilevel)',
                      ),
                      const SizedBox(height: 18),
                      const Divider(color: Color(0xFFE0E0E0), thickness: 1),
                      const SizedBox(height: 26),
                      const Text(
                        'SETTINGS',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 1,
                          color: Color(0xFF111111),
                        ),
                      ),
                      const SizedBox(height: 18),
                      _buildDrawerMenuItem(
                        icon: Icons.palette_rounded,
                        iconColor: const Color(0xFF5D8BFF),
                        boxColor: const Color(0xFFEEF3FF),
                        title: 'Highlights',
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
                            const Expanded(
                              child: Text(
                                'Dark Mode',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF111111),
                                ),
                              ),
                            ),
                            Switch(
                              value: isDarkMode,
                              onChanged: (value) {
                                setState(() {
                                  isDarkMode = value;
                                });
                              },
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xFF6F42C1),
                              inactiveThumbColor: Colors.white,
                              inactiveTrackColor: const Color(0xFFD9D9D9),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 22),
                      Row(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: const Color(0xFFD8E9FF),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Icon(
                              Icons.trending_up_rounded,
                              size: 38,
                              color: Color(0xFF77A6FF),
                            ),
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Jobie - Job Portal',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF111111),
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'App Version 1.0',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF8E8E93),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
      decoration: const BoxDecoration(
        color: Color(0xFF4DA3F0),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              image: const DecorationImage(
                image: NetworkImage('https://i.pravatar.cc/150?img=11'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Henry Kanwil',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerMenuItem({
    required IconData icon,
    required Color iconColor,
    required Color boxColor,
    required String title,
    String? badgeText,
    Color? badgeColor,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: boxColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Color(0xFF111111),
              ),
            ),
          ),
          if (badgeText != null)
            Container(
              width: 24,
              height: 24,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: badgeColor ?? const Color(0xFFFF5C5C),
                shape: BoxShape.circle,
              ),
              child: Text(
                badgeText,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          const SizedBox(width: 10),
          const Icon(
            Icons.chevron_right_rounded,
            color: Color(0xFF9A9A9A),
            size: 24,
          ),
        ],
      ),
    );
  }

  Widget _buildMenubarArea() {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: const Color(0xFFB8B8BE),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, size: 34),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_rounded, size: 32),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail_outline_rounded, size: 32),
            label: 'Mail',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded, size: 30),
            label: 'Menu',
          ),
        ],
      ),
    );
  }
}