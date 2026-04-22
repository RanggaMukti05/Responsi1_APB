import 'package:flutter/material.dart';
import 'package:responsi1apb/screens/profile/chat_room_page.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color bgColor = Color(0xFFF5F5F5);
    const Color titleColor = Color(0xFF212529);
    const Color textColor = Color(0xFF8E8E93);
    const Color primaryColor = Color(0xFF6F42C1);

    final List<Map<String, String>> chats = [
      {
        'name': 'Gustauv Semalam',
        'message': 'Roger that sir, thankyou',
        'time': '2m ago',
        'image': 'https://i.pravatar.cc/150?img=12',
      },
      {
        'name': 'Claudia Surrr',
        'message': 'Ok. Lorem ipsum dolor sect...',
        'time': '2m ago',
        'image': 'https://i.pravatar.cc/150?img=32',
      },
      {
        'name': 'Rose Melati',
        'message': 'Lorem ipsum dolor',
        'time': '2m ago',
        'image': 'https://i.pravatar.cc/150?img=47',
      },
      {
        'name': 'Olivia James',
        'message': 'Ok. Lorem ipsum dolor sect...',
        'time': '2m ago',
        'image': 'https://i.pravatar.cc/150?img=5',
      },
      {
        'name': 'Daphne Putri',
        'message': 'Ok. Lorem ipsum dolor sect...',
        'time': '2m ago',
        'image': 'https://i.pravatar.cc/150?img=20',
      },
      {
        'name': 'David Mckanzie',
        'message': 'Lorem ipsum dolor sit dvc ..',
        'time': '2m ago',
        'image': 'https://i.pravatar.cc/150?img=12',
      },
      {
        'name': 'Mace jean',
        'message': 'Ok. Lorem ipsum dolor sect...',
        'time': '2m ago',
        'image': 'https://i.pravatar.cc/150?img=47',
      },
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
                border: Border(
                  bottom: BorderSide(color: Color(0xFFEAEAEA)),
                ),
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
                        'Message',
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
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
                child: Column(
                  children: [
                    Container(
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(32),
                        border: Border.all(color: const Color(0xFFE1E1E1)),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: Colors.grey.shade400,
                            size: 34,
                          ),
                          hintText: 'Search job here...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 17,
                          ),
                          border: InputBorder.none,
                          contentPadding:
                          const EdgeInsets.symmetric(vertical: 18),
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    ListView.separated(
                      itemCount: chats.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (_, __) => const Divider(
                        color: Color(0xFFE6E6E6),
                        height: 22,
                      ),
                      itemBuilder: (context, index) {
                        final chat = chats[index];

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ChatRoomPage(
                                  userName: chat['name']!,
                                  userImage: chat['image']!,
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(14),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    CircleAvatar(
                                      radius: 28,
                                      backgroundImage:
                                      NetworkImage(chat['image']!),
                                    ),
                                    Positioned(
                                      right: -1,
                                      top: -1,
                                      child: Container(
                                        width: 18,
                                        height: 18,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF5BE26C),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: Colors.white,
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        chat['name']!,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700,
                                          color: titleColor,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.done_all_rounded,
                                            color: primaryColor,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              chat['message']!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                color: textColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    chat['time']!,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
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
          currentIndex: 2,
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
              icon: Icon(Icons.mail_rounded, size: 32),
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