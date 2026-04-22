import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  final String userName;
  final String userImage;

  const ChatRoomPage({
    super.key,
    required this.userName,
    required this.userImage,
  });

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final TextEditingController messageController = TextEditingController();

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF6F42C1);
    const Color bgColor = Color(0xFFEDEAF7);
    const Color titleColor = Color(0xFF212529);
    const Color textColor = Color(0xFF8E8E93);

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
                  CircleAvatar(
                    radius: 22,
                    backgroundImage: NetworkImage(widget.userImage),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.userName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: titleColor,
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
                padding: const EdgeInsets.fromLTRB(18, 16, 18, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _leftBubble(
                      text: 'Do you have a time for interviews today?',
                      time: '4.30 AM',
                    ),
                    const SizedBox(height: 4),
                    _rightBubble(
                      text: 'Yes, I have.',
                      time: '9.30 AM',
                      color: primaryColor,
                    ),
                    const SizedBox(height: 18),
                    _leftBubble(
                      text: 'Okay, please meet me at Franklin Avenue at 5 pm',
                      time: '9:44 AM',
                    ),
                    const SizedBox(height: 4),
                    _rightBubble(
                      text: 'Roger that sir, thankyou',
                      time: '9.30 AM',
                      color: primaryColor,
                    ),
                    const SizedBox(height: 18),
                    _leftBubble(
                      text: 'Do you have a time',
                      time: '10:44 AM',
                    ),
                    const SizedBox(height: 4),
                    _rightBubble(
                      text: 'Yes',
                      time: '9.30 AM',
                      color: primaryColor,
                    ),
                    const SizedBox(height: 18),
                    _leftBubble(
                      text: 'Okay',
                      time: '1:15 AM',
                    ),
                    const SizedBox(height: 4),
                    _rightBubble(
                      text: 'Yes',
                      time: '9.30 AM',
                      color: primaryColor,
                    ),
                    const SizedBox(height: 16),
                    _rightBubble(
                      text: 'Yes',
                      time: '9.30 AM',
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 18),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: Color(0xFFE2E2E2)),
                ),
              ),
              child: Container(
                height: 68,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(34),
                  border: Border.all(color: const Color(0xFFE2E2E2)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE4E1E1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.sentiment_satisfied_alt_rounded,
                        color: Color(0xFF9C9C9C),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type message...',
                          hintStyle: TextStyle(
                            color: textColor,
                            fontSize: 17,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Container(
                      width: 52,
                      height: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF0EAFB),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send_rounded,
                        color: primaryColor,
                        size: 30,
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

  Widget _leftBubble({
    required String text,
    required String time,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 17,
              height: 1.35,
              color: Color(0xFF212529),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          time,
          style: const TextStyle(
            color: Color(0xFF9B9B9B),
            fontSize: 15,
          ),
        ),
      ],
    );
  }

  Widget _rightBubble({
    required String text,
    required String time,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 260),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 17,
                height: 1.35,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          time,
          style: const TextStyle(
            color: Color(0xFF9B9B9B),
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}