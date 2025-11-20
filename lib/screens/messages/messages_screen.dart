import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final chats = [
      ChatPreview(
        name: '张小美',
        petName: 'Max',
        lastMessage: '好的，明天见！',
        time: '2分钟前',
        unreadCount: 2,
        avatar: Icons.person,
        isOnline: true,
      ),
      ChatPreview(
        name: '李明',
        petName: 'Luna',
        lastMessage: '谢谢你的推荐！',
        time: '1小时前',
        unreadCount: 0,
        avatar: Icons.person,
        isOnline: false,
      ),
      ChatPreview(
        name: '王芳',
        petName: 'Charlie',
        lastMessage: '我家狗狗超喜欢那个公园！',
        time: '3小时前',
        unreadCount: 1,
        avatar: Icons.person,
        isOnline: true,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('消息'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: chats.length,
        separatorBuilder: (context, index) => Divider(
          color: AppColors.divider,
          height: 1,
          indent: 80,
        ),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: AppColors.primary,
                  child: Icon(chat.avatar, color: AppColors.background),
                ),
                if (chat.isOnline)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: AppColors.online,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.background,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    chat.name,
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  chat.time,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            subtitle: Row(
              children: [
                Expanded(
                  child: Text(
                    chat.lastMessage,
                    style: TextStyle(
                      color: chat.unreadCount > 0
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                      fontSize: 14,
                      fontWeight: chat.unreadCount > 0
                          ? FontWeight.w500
                          : FontWeight.normal,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (chat.unreadCount > 0) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${chat.unreadCount}',
                      style: const TextStyle(
                        color: AppColors.background,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    name: chat.name,
                    petName: chat.petName,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatPreview {
  final String name;
  final String petName;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final IconData avatar;
  final bool isOnline;

  ChatPreview({
    required this.name,
    required this.petName,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.avatar,
    required this.isOnline,
  });
}
