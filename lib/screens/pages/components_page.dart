import 'package:flutter/material.dart';

// Import daftar halaman komponen Anda
import 'alert_page.dart';
import 'badge_page.dart';
import 'button_group_page.dart';
import 'button_page.dart';
import 'card_page.dart';
import 'divider_page.dart';
import 'dropdown_page.dart';
import 'input_page.dart';
import 'language_page.dart';
import 'light_gallery_page.dart';
import 'list_group_page.dart';
import 'modal_page.dart';
import 'progress_bar_page.dart';
import 'social_button_page.dart';
import 'typography_page.dart';
import 'toast_page.dart';
import 'treeview_page.dart';
import 'switch_page.dart';
import 'swiper_page.dart';
import 'steppers_page.dart';
import 'spinner_page.dart';
import 'range_slider_page.dart';

class ComponentsPage extends StatelessWidget {
  const ComponentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar komponen dengan desain yang Anda inginkan
    final List<Widget> menuItems = [
      _buildItem(
        context,
        'Alert',
        Icons.notifications_active,
        Colors.amber,
        const AlertPage(),
      ),
      _buildItem(
        context,
        'Button',
        Icons.smart_button,
        Colors.orange,
        const ButtonPage(),
      ),
      _buildItem(
        context,
        'Badge',
        Icons.local_offer,
        Colors.pink,
        const BadgePage(),
      ),
      _buildItem(
        context,
        'Button Group',
        Icons.view_column,
        Colors.lightBlue,
        const ButtonGroupPage(),
      ),
      _buildItem(
        context,
        'Card',
        Icons.credit_card,
        Colors.blueGrey,
        const CardPage(),
      ),
      _buildItem(
        context,
        'Divider',
        Icons.horizontal_rule,
        Colors.pink,
        const DividerPage(),
      ),
      _buildItem(
        context,
        'Dropdown',
        Icons.arrow_drop_down_circle,
        Colors.teal,
        const DropdownPage(),
      ),
      _buildItem(
        context,
        'Input',
        Icons.input,
        Colors.deepOrange,
        const InputPage(),
      ),
      _buildItem(
        context,
        'Language',
        Icons.language,
        Colors.brown,
        const LanguagePage(),
      ),
      _buildItem(
        context,
        'Lightgallery',
        Icons.collections,
        Colors.purple,
        const LightGalleryPage(),
      ),
      _buildItem(
        context,
        'List Group',
        Icons.format_list_bulleted,
        Colors.pinkAccent,
        const ListGroupPage(),
      ),
      _buildItem(
        context,
        'Modal',
        Icons.web_asset,
        Colors.blue,
        const ModalPage(),
      ),
      _buildItem(
        context,
        'Progressbar',
        Icons.bar_chart,
        Colors.redAccent,
        const ProgressBarPage(),
      ),
      _buildItem(
        context,
        'Spinner',
        Icons.cached,
        Colors.blue,
        const SpinnerPage(),
      ),
      _buildItem(
        context,
        'RangeSlider',
        Icons.linear_scale,
        Colors.pinkAccent,
        const RangeSliderPage(),
      ),
      _buildItem(
        context,
        'Social',
        Icons.share,
        Colors.indigo,
        const SocialButtonPage(),
      ),
      _buildItem(
        context,
        'Typography',
        Icons.text_fields,
        Colors.amber,
        const TypographyPage(),
      ),
      _buildItem(
        context,
        'Toast',
        Icons.announcement,
        Colors.lightBlueAccent,
        const ToastPage(),
      ),
      _buildItem(
        context,
        'Treeview',
        Icons.account_tree,
        Colors.red,
        const TreeviewPage(),
      ),
      _buildItem(
        context,
        'Switch',
        Icons.toggle_on,
        Colors.pink,
        const SwitchPage(),
      ),
      _buildItem(
        context,
        'Swiper',
        Icons.swipe,
        Colors.orange,
        const SwiperPage(),
      ),
      _buildItem(
        context,
        'Stepper',
        Icons.format_list_numbered,
        Colors.orangeAccent,
        const SteppersPage(),
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Components'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(children: menuItems),
    );
  }

  // Fungsi pembantu untuk membuat desain item list
  Widget _buildItem(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
    Widget page,
  ) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(
            0.1,
          ), // Warna background tipis sesuai warna ikon
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
    );
  }
}
