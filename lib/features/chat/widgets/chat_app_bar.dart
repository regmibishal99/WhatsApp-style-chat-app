import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../models/contact.dart';

class ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Contact contact;
  const ChatAppBar({super.key, required this.contact});

  static const List<Color> _avatarColors = [
    Color(0xFF00BCD4), Color(0xFFE91E63), Color(0xFF9C27B0),
    Color(0xFF4CAF50), Color(0xFFFF5722), Color(0xFF3F51B5),
    Color(0xFFFF9800), Color(0xFF009688), Color(0xFF607D8B),
  ];

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      backgroundColor: isDark ? AppTheme.appBarDark : AppTheme.appBarLight,
      leadingWidth: 30,
      titleSpacing: 0,
      title: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            // Hero animation on avatar
            Hero(
              tag: 'avatar_${contact.id}',
              child: CircleAvatar(
                radius: 20,
                backgroundColor: _avatarColors[
                    contact.avatarColorIndex % _avatarColors.length],
                child: Text(
                  contact.avatarInitials,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    contact.name,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    contact.isOnline ? 'online' : 'last seen recently',
                    style: TextStyle(
                      color: contact.isOnline
                          ? Colors.greenAccent.shade100
                          : Colors.white60,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.videocam, color: Colors.white),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.call, color: Colors.white),
          onPressed: () {},
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert, color: Colors.white),
          onSelected: (_) {},
          itemBuilder: (_) => const [
            PopupMenuItem(value: 'view',    child: Text('View contact')),
            PopupMenuItem(value: 'media',   child: Text('Media, links and docs')),
            PopupMenuItem(value: 'search',  child: Text('Search')),
            PopupMenuItem(value: 'mute',    child: Text('Mute notifications')),
            PopupMenuItem(value: 'wallpaper', child: Text('Wallpaper')),
          ],
        ),
      ],
    );
  }
}