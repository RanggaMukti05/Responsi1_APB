import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. MENGAMBIL WARNA DARI TEMA GLOBAL SECARA OTOMATIS
    final primaryColor = Theme.of(context).primaryColor;
    final bgColor = Theme.of(context).scaffoldBackgroundColor;
    final titleColor = Theme.of(context).textTheme.bodyLarge?.color;
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;
    final cardColor = Theme.of(context).cardColor;
    final borderColor = Theme.of(context).dividerColor;
    final lightPurple = primaryColor.withOpacity(0.1); 

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
              decoration: BoxDecoration(
                color: cardColor,
                border: Border(
                  bottom: BorderSide(color: borderColor),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 48), // Spacer pengganti tombol back
                  Expanded(
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
                      child: Image.network(
                        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=1200&auto=format&fit=crop',
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
                              color: cardColor,
                              borderRadius: BorderRadius.circular(22),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 18,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: Image.network(
                                'https://i.pravatar.cc/300?img=11',
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
                          Text(
                            'Henry Kanwil',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: titleColor,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Programmer',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            children: [
                              _ContactCircle(icon: Icons.call_rounded, color: primaryColor),
                              _ContactCircle(icon: Icons.mail_rounded, color: primaryColor),
                              _ContactCircle(icon: Icons.location_on_rounded, color: primaryColor),
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'My Resume',
                                        style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(height: 14),
                                      Text(
                                        'david_resume.pdf',
                                        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.more_vert_rounded, color: Colors.white, size: 34),
                              ],
                            ),
                          ),
                          const SizedBox(height: 34),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Skill', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: titleColor)),
                          ),
                          const SizedBox(height: 18),
                          GridView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: skills.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, mainAxisSpacing: 18, crossAxisSpacing: 18, childAspectRatio: 0.83,
                            ),
                            itemBuilder: (context, index) {
                              final skill = skills[index];
                              return _SkillCard(
                                title: skill['title'] as String,
                                percent: skill['percent'] as int,
                                progressColor: skill['color'] as Color,
                                bgColor: lightPurple,
                                textColor: titleColor,
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
      // PERHATIKAN: bottomNavigationBar dihapus dari sini karena numpang di Dashboard!
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
        border: Border.all(color: Theme.of(context).dividerColor),
        color: Colors.transparent,
      ),
      child: Icon(icon, color: color, size: 38),
    );
  }
}

class _SkillCard extends StatelessWidget {
  final String title;
  final int percent;
  final Color progressColor;
  final Color bgColor;
  final Color? textColor;

  const _SkillCard({
    required this.title,
    required this.percent,
    required this.progressColor,
    required this.bgColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 94,
            height: 94,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 94,
                  height: 94,
                  child: CircularProgressIndicator(
                    value: percent / 100,
                    strokeWidth: 10,
                    backgroundColor: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                  ),
                ),
                Container(
                  width: 62,
                  height: 62,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$percent%',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: textColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}