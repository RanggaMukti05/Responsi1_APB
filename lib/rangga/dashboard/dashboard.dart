import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class JobieDashboard extends StatefulWidget {
  const JobieDashboard({Key? key}) : super(key: key);

  @override
  State<JobieDashboard> createState() => _JobieDashboardState();
}

class _JobieDashboardState extends State<JobieDashboard> {
  int _currentIndex = 0;

  // Exact colors diekstrak dari style.css
  final Color primaryColor = const Color(0xFF673AB7);
  final Color secondaryColor = const Color(0xFF48A9F8);
  final Color bgColor = const Color(0xFFF7F7F7);
  final Color borderColor = const Color(0xFFDDDDDD);
  final Color titleColor = const Color(0xFF212529);
  final Color textColor = const Color(0xFF7E7E7E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildBannerAndSearch(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFeaturesBox(),
                  const SizedBox(height: 30),
                  _buildCategories(),
                  const SizedBox(height: 30),
                  _buildRecommendedJobs(),
                  const SizedBox(height: 30),
                  _buildRecentJobs(),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildMenubarArea(),
    );
  }

  Widget _buildBannerAndSearch() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        // Banner Wrapper
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            bottom: 25,
          ), // Ruang kompensasi search bar
          padding: const EdgeInsets.only(
            top: 60,
            bottom: 65,
            left: 15,
            right: 15,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment(-0.8, -1.0),
              end: Alignment(0.8, 1.0),
              colors: [Color(0xFF673AB7), Color(0xFF9A70E5)],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Navigasi Atas
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, color: Colors.white, size: 28),
                  Row(
                    children: const [
                      Icon(
                        Icons.palette_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                      SizedBox(width: 15),
                      Icon(
                        Icons.dark_mode_outlined,
                        color: Colors.white,
                        size: 24,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // Profil
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Text(
                        'Henry Kanwil',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 45,
                    height: 45,
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
        ),
        // Search Bar Melayang (.input-group)
        Positioned(
          bottom: 0,
          left: 15,
          right: 15,
          child: Container(
            height: 55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Color(0xFFB9B9B9)),
                hintText: 'Search job here...',
                hintStyle: TextStyle(color: textColor, fontSize: 14),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- 2. FEATURES BOX (.features-box) ---
  Widget _buildFeaturesBox() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 169,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.work_outline, color: Colors.white, size: 30),
                Spacer(),
                Text(
                  '29',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                Text(
                  'Jobs Applied',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Container(
            height: 169,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 12,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.person_outline, color: Colors.white, size: 30),
                Spacer(),
                Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    height: 1.2,
                  ),
                ),
                Text(
                  'Interviews',
                  style: TextStyle(color: Colors.white, fontSize: 14),
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
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: titleColor,
          ),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // 4 kolom ke samping
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: iconFiles.length, // Pas 8 ikon
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: borderColor),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: IconButton(
                icon: SvgPicture.asset(
                  iconFiles[index],
                  width: 28,
                  height: 28,
                  colorFilter: ColorFilter.mode(
                    primaryColor, // Otomatis mewarnai SVG kamu jadi ungu
                    BlendMode.srcIn,
                  ),
                ),
                onPressed: () {
                  // Aksi saat tombol kategori diklik
                },
              ),
            );
          },
        ),
      ],
    );
  }

  // --- 4. RECOMMENDED JOBS (.recomand-swiper) ---
  Widget _buildRecommendedJobs() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recomended Jobs',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
            ),
            Row(
              children: [
                Container(
                  width: 20,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: primaryColor,
                  ),
                ),
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE5E5E5),
                  ),
                ),
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE5E5E5),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 15),
        SizedBox(
          height: 110,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: 3,
            separatorBuilder: (_, __) => const SizedBox(width: 15),
            itemBuilder: (context, index) {
              return Container(
                width: 280,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: borderColor),
                ),
                child: Row(
                  children: [
                    // ---> MEMANGGIL LOGO HIJAU <---
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/logo/logo_hijau.png', // Sudah pakai nama baru
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.red.shade100,
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Software Engineer',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: titleColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Jakarta, Indonesia',
                            style: TextStyle(color: textColor, fontSize: 12),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(
                                Icons.monetization_on_outlined,
                                color: primaryColor,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '\$500 - \$1,000',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
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

  // --- 5. RECENT JOBS (Vertical List) ---
  Widget _buildRecentJobs() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Jobs',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: titleColor,
              ),
            ),
            Text(
              'More',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            List<String> titles = [
              'Software Engineer',
              'Database Engineer',
              'Software Engineer',
            ];
            List<String> companies = [
              'Highspeed Studios',
              'Lunar Djaja Corp.',
              'Highspeed Studios',
            ];
            List<String> locations = [
              'Jakarta, Indonesia',
              'London, United Kingdom',
              'Medan, Indonesia',
            ];

            List<String> logoFiles = [
              'assets/images/logo/logo_oren.png',
              'assets/images/logo/logo_ungu.png',
              'assets/images/logo/logo_abu.png',
            ];

            return Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ---> MEMANGGIL GAMBAR LOGO RECENT JOBS <---
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      logoFiles[index],
                      width: 55,
                      height: 55,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 55,
                        height: 55,
                        color: Colors.red.shade100,
                        child: const Icon(
                          Icons.broken_image,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          companies[index],
                          style: TextStyle(
                            fontSize: 12,
                            color: textColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          titles[index],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: titleColor,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.monetization_on_outlined,
                              size: 14,
                              color: primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '\$500 - \$1,000',
                              style: TextStyle(fontSize: 13, color: textColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.work, size: 14, color: primaryColor),
                            const SizedBox(width: 4),
                            Text(
                              locations[index],
                              style: TextStyle(fontSize: 13, color: textColor),
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
      ],
    );
  }

  // --- 6. MENUBAR AREA (.menubar-area) ---
  Widget _buildMenubarArea() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 26,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: primaryColor,
        unselectedItemColor: titleColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Icon(Icons.home_filled, size: 24),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Icon(Icons.description_outlined, size: 24),
            ),
            label: 'Pages',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Icon(Icons.chat_bubble_outline, size: 24),
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Icon(Icons.person_outline, size: 24),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
