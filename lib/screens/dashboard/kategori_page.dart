import 'package:flutter/material.dart';
import 'package:responsi1apb/main.dart'; // Untuk memanggil tema warna

class KategoriPage extends StatefulWidget {
  const KategoriPage({Key? key}) : super(key: key);

  @override
  State<KategoriPage> createState() => _KategoriPageState();
}

class _KategoriPageState extends State<KategoriPage> {
  // Key untuk mengontrol Scaffold agar bisa buka Sidebar dari tombol mana saja
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Daftar filter/tag aktif sesuai referensi
  List<String> activeTags = ['Design', 'Development', 'Jakarta'];

  // Data list pekerjaan sesuai gambar referensi "Search"
  final List<Map<String, String>> searchJobs = [
    {
      'title': 'Software Engineer',
      'company': 'Highspeed Studios',
      'salary': '\$500 - \$1,000',
      'location': 'Jakarta, Indonesia',
      'logo': 'assets/images/logo/logo_oren.png',
    },
    {
      'title': 'UI/UX Designer',
      'company': 'Lunar Djaja Corp.',
      'salary': '\$500 - \$1,000',
      'location': 'Jakarta, Indonesia',
      'logo': 'assets/images/logo/logo_ungu.png',
    },
    {
      'title': 'Graphic Designer',
      'company': 'Highspeed Studios',
      'salary': '\$500 - \$1,000',
      'location': 'Jakarta, Indonesia',
      'logo': 'assets/images/logo/logo_hijau.png',
    },
    {
      'title': 'Database Engineer',
      'company': 'Lunar Djaja Corp.',
      'salary': '\$500 - \$1,000',
      'location': 'London, United Kingdom',
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
        final textColor = Theme.of(context).textTheme.bodyLarge?.color;
        final subTextColor = const Color(0xFF8E8E93);
        final cardColor = Theme.of(context).cardColor;
        final bgColor = Theme.of(context).scaffoldBackgroundColor;

        return Scaffold(
          key: _scaffoldKey, 
          backgroundColor: bgColor,
          // FIX: SIDEBAR SEKARANG DI KIRI (Drawer)
          drawer: _buildSidebar(primaryColor), 
          appBar: AppBar(
            backgroundColor: bgColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: textColor, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              "Search",
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.grid_view_rounded, color: textColor, size: 22),
                onPressed: () {
                  // MEMBUKA DRAWER DARI SISI KIRI
                  _scaffoldKey.currentState?.openDrawer();
                },
              ),
              const SizedBox(width: 8),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              
              // KOTAK PENCARIAN & FILTER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      )
                    ],
                  ),
                  child: Row(
                    children: [
                      const SizedBox(width: 16),
                      const Icon(Icons.search_rounded, color: Color(0xFFB9B9B9), size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: textColor),
                          decoration: const InputDecoration(
                            hintText: "Search job here...",
                            hintStyle: TextStyle(color: Color(0xFFB9B9B9), fontSize: 15),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(Icons.tune_rounded, color: Colors.white, size: 22),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // TAGS AREA
              if (activeTags.isNotEmpty)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: activeTags.map((tag) {
                      return Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Theme.of(context).dividerColor, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            Text(
                              tag,
                              style: TextStyle(color: subTextColor, fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                setState(() => activeTags.remove(tag));
                              },
                              child: const Icon(Icons.close_rounded, size: 16, color: Color(0xFFB9B9B9)),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              
              if (activeTags.isNotEmpty) const SizedBox(height: 24),

              // TEKS JUMLAH PEKERJAAN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "39 Jobs Founds",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // LIST PEKERJAAN
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  physics: const BouncingScrollPhysics(),
                  itemCount: searchJobs.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final job = searchJobs[index];
                    return Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Theme.of(context).dividerColor),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(14),
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
                              children: [
                                Text(
                                  job['company']!,
                                  style: TextStyle(color: subTextColor, fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  job['title']!,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Icon(Icons.payments_outlined, color: primaryColor, size: 18),
                                    const SizedBox(width: 6),
                                    Text(
                                      job['salary']!,
                                      style: TextStyle(color: subTextColor, fontSize: 13, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    Icon(Icons.work_outline_rounded, color: primaryColor, size: 18),
                                    const SizedBox(width: 6),
                                    Text(
                                      job['location']!,
                                      style: TextStyle(color: subTextColor, fontSize: 13, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.bookmark_border_rounded, color: Color(0xFFB9B9B9), size: 24),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
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
                      width: 56, height: 56, fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 56, height: 56, color: Colors.grey.shade400,
                        child: const Icon(Icons.person, color: Colors.white, size: 30),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Good Morning', style: TextStyle(color: Colors.white, fontSize: 14)),
                        SizedBox(height: 4),
                        Text('Henry Kanwil', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('MAIN MENU', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                    const SizedBox(height: 16),
                    _drawerItem(Icons.favorite_rounded, const Color(0xFFFF6F91), const Color(0xFFFFEEF2), 'Welcome'),
                    _drawerItem(
                      Icons.home_rounded, 
                      const Color(0xFFFF66B3), 
                      const Color(0xFFFFEEF7), 
                      'Home', 
                      onTap: () { 
                        Navigator.pop(context); 
                        Navigator.pop(context); 
                      }
                    ),
                    _drawerItem(Icons.layers_rounded, const Color(0xFFFFA14A), const Color(0xFFFFF4E7), 'Pages'),
                    _drawerItem(Icons.grid_view_rounded, const Color(0xFF47B5FF), const Color(0xFFEAF7FF), 'Components'),
                    _drawerItem(Icons.notifications_rounded, const Color(0xFF19B38C), const Color(0xFFE8FAF4), 'Notification', badge: '1', badgeColor: const Color(0xFFFF5C5C)),
                    _drawerItem(Icons.person_rounded, const Color(0xFFE3B100), const Color(0xFFFFF7DD), 'Profile'),
                    _drawerItem(Icons.chat_bubble_rounded, const Color(0xFF56C3EA), const Color(0xFFEAF9FF), 'Chat', badge: '5', badgeColor: const Color(0xFF56C3EA)),
                    _drawerItem(Icons.logout_rounded, const Color(0xFFFF7A9C), const Color(0xFFFFEEF2), 'Logout'),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 20),
                    Text('SETTINGS', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                    const SizedBox(height: 16),
                    _drawerItem(
                      Icons.palette_rounded, 
                      const Color(0xFF5D8BFF), 
                      const Color(0xFFEEF3FF), 
                      'Highlights', 
                      onTap: () { 
                        Navigator.pop(context); 
                        _showColorPicker(); 
                      }
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Container(width: 38, height: 38, decoration: BoxDecoration(color: const Color(0xFFE8FAF4), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.nightlight_round, color: Color(0xFF0FA37F), size: 20)),
                          const SizedBox(width: 16),
                          Expanded(child: Text('Dark Mode', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).textTheme.bodyLarge?.color))),
                          ValueListenableBuilder<ThemeMode>(
                            valueListenable: themeNotifier,
                            builder: (context, currentMode, _) {
                              return Switch(
                                value: currentMode == ThemeMode.dark,
                                onChanged: (val) => themeNotifier.value = val ? ThemeMode.dark : ThemeMode.light,
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

  Widget _drawerItem(IconData icon, Color iconColor, Color boxColor, String title, {String? badge, Color? badgeColor, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(width: 38, height: 38, decoration: BoxDecoration(color: boxColor, borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: iconColor, size: 20)),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Theme.of(context).textTheme.bodyLarge?.color)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (badge != null) Container(padding: const EdgeInsets.all(6), decoration: BoxDecoration(color: badgeColor, shape: BoxShape.circle), child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }
}