import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/time_formatter.dart';
import '../../../data/chat_data.dart';
import '../../../models/contact.dart';
import '../../../models/message.dart';
import '../../chat/screens/chat_screen.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;
  const ContactTile({super.key, required this.contact});

  static const List<Color> _avatarColors = [
    Color(0xFF00BCD4), Color(0xFFE91E63), Color(0xFF9C27B0),
    Color(0xFF4CAF50), Color(0xFFFF5722), Color(0xFF3F51B5),
    Color(0xFFFF9800), Color(0xFF009688), Color(0xFF607D8B),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark   = Theme.of(context).brightness == Brightness.dark;
    final messages = ChatData.allMessages[contact.id] ?? [];
    final lastMsg  = messages.isNotEmpty ? messages.last : null;

    return InkWell(
      onTap: () => Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => ChatScreen(contact: contact),
          transitionsBuilder: (_, anim, __, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
            child: child,
          ),
        ),
      ),
      child: Container(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            // Avatar with Hero
            Hero(
              tag: 'avatar_${contact.id}',
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor:
                        _avatarColors[contact.avatarColorIndex % _avatarColors.length],
                    child: Text(
                      contact.avatarInitials,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ),
                  if (contact.isOnline)
                    Positioned(
                      right: 0, bottom: 0,
                      child: Container(
                        width: 13, height: 13,
                        decoration: BoxDecoration(
                          color: AppTheme.onlineColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isDark ? AppTheme.surfaceDark : Colors.white,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 14),
            // Name + last message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          contact.name,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: isDark ? Colors.white : Colors.black87,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        TimeFormatter.chatTime(contact.lastMessageTime),
                        style: TextStyle(
                          fontSize: 12,
                          color: contact.unreadCount > 0
                              ? AppTheme.primaryGreen
                              : (isDark ? Colors.white38 : Colors.black38),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      // Sent tick icons
                      if (lastMsg != null && lastMsg.isSentByMe) ...[
                        Icon(
                          lastMsg.status == MessageStatus.read
                              ? Icons.done_all
                              : lastMsg.status == MessageStatus.delivered
                                  ? Icons.done_all
                                  : Icons.done,
                          size: 16,
                          color: lastMsg.status == MessageStatus.read
                              ? AppTheme.readColor
                              : (isDark ? Colors.white38 : Colors.black38),
                        ),
                        const SizedBox(width: 3),
                      ],
                      if (contact.isMuted)
                        Padding(
                          padding: const EdgeInsets.only(right: 3),
                          child: Icon(Icons.volume_off,
                              size: 14,
                              color: isDark ? Colors.white38 : Colors.black38),
                        ),
                      Expanded(
                        child: Text(
                          contact.lastMessage,
                          style: TextStyle(
                            fontSize: 13,
                            color: isDark ? Colors.white54 : Colors.black54,
                            fontWeight: contact.unreadCount > 0
                                ? FontWeight.w500
                                : FontWeight.normal,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const SizedBox(width: 8),
                      if (contact.unreadCount > 0)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: contact.isMuted
                                ? (isDark ? Colors.white24 : Colors.black26)
                                : AppTheme.primaryGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            '${contact.unreadCount}',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}