import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsi1apb/aldi/detail_job.dart';

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
              const Icon(Icons.grid_view_rounded, color: Colors.white, size: 30),
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