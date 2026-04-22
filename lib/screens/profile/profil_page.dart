import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF6F42C1);
    const Color bgColor = Color(0xFFF5F5F5);
    const Color titleColor = Color(0xFF212529);
    const Color textColor = Color(0xFF8E8E93);
    const Color lightPurple = Color(0xFFEAE4F4);

    final skills = [
      {'title': 'PHP', 'percent': 66, 'color': const Color(0xFFF08A24)},
      {'title': 'Java', 'percent': 48, 'color': const Color(0xFF2EB24D)},
      {'title': 'MySQL', 'percent': 56, 'color': const Color(0xFF2D8CCF)},
      {'title': 'React N', 'percent': 34, 'color': const Color(0xFF2D8CCF)},
      {'title': 'CSS', 'percent': 86, 'color': const Color(0xFF4A21A8)},
    ];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 78,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(bottom: BorderSide(color: Color(0xFFEAEAEA))),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Color(0xFF9D9DA5),
                      size: 28,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: titleColor,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.grid_view_rounded,
                      color: Color(0xFF9D9DA5),
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        'assets/images/profil_cover.png',
                        height: 215,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 215,
                            width: double.infinity,
                            color: Colors.grey.shade300,
                            child: const Icon(Icons.broken_image, size: 42),
                          );
                        },
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -78),
                      child: Column(
                        children: [
                          Container(
                            width: 142,
                            height: 142,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.asset(
                                'assets/images/profil.png',
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    color: Colors.grey.shade300,
                                    child: const Icon(Icons.person, size: 46),
                                  );
                                },
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Henry Kanwil',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: titleColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Programmer',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                height: 1.5,
                                color: textColor,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(height: 26),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              _ContactCircle(
                                icon: Icons.call_rounded,
                                color: primaryColor,
                              ),
                              _ContactCircle(
                                icon: Icons.mail_rounded,
                                color: primaryColor,
                              ),
                              _ContactCircle(
                                icon: Icons.location_on_rounded,
                                color: primaryColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: const Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'My Resume',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(height: 14),
                                      Text(
                                        'david_resume.pdf',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(
                                  Icons.more_vert_rounded,
                                  color: Colors.white,
                                  size: 34,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 34),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Skill',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                                color: titleColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: skills.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 18,
                                  crossAxisSpacing: 18,
                                  childAspectRatio: 0.72,
                                ),
                            itemBuilder: (context, index) {
                              final skill = skills[index];
                              return _SkillCard(
                                title: skill['title'] as String,
                                percent: skill['percent'] as int,
                                progressColor: skill['color'] as Color,
                                bgColor: lightPurple,
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
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(top: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 18,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: 3,
          onTap: (_) {},
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: primaryColor,
          unselectedItemColor: const Color(0xFFB7B7BF),
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
      ),
    );
  }
}

class _ContactCircle extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _ContactCircle({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFE4DDF1)),
        color: Colors.transparent,
      ),
      child: Icon(icon, color: color, size: 38),
    );
  }
}

// ==========================================
// KODE YANG SUDAH DIPERBAIKI ADA DI BAWAH INI
// ==========================================
class _SkillCard extends StatelessWidget {
  final String title;
  final int percent;
  final Color progressColor;
  final Color bgColor;

  const _SkillCard({
    required this.title,
    required this.percent,
    required this.progressColor,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Ubah posisi ke center
        children: [
          // Lingkaran Persentase dibungkus Expanded & FittedBox
          Expanded(
            flex: 3,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: SizedBox(
                width: 82,
                height: 82,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 82,
                      height: 82,
                      child: CircularProgressIndicator(
                        value: percent / 100,
                        strokeWidth: 8,
                        backgroundColor: Colors.white,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          progressColor,
                        ),
                      ),
                    ),
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '$percent%',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF111111),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10), // Jarak disesuaikan
          // Teks Judul dibungkus Expanded (sudah dari awal)
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF212529),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
