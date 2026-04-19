import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class StoryAvatar extends StatelessWidget {
  final String name;
  final String initials;
  final int    colorIndex;
  final bool   isMe;
  final bool   isOnline;

  const StoryAvatar({
    super.key,
    required this.name,
    required this.initials,
    required this.colorIndex,
    this.isMe    = false,
    this.isOnline = false,
  });

  static const List<Color> _colors = [
    Color(0xFF00BCD4), Color(0xFFE91E63), Color(0xFF9C27B0),
    Color(0xFF4CAF50), Color(0xFFFF5722), Color(0xFF3F51B5),
    Color(0xFFFF9800), Color(0xFF009688), Color(0xFF607D8B),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(right: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isMe
                      ? null
                      : Border.all(color: AppTheme.primaryGreen, width: 2),
                ),
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: _colors[colorIndex % _colors.length],
                  child: isMe
                      ? const Icon(Icons.add, color: Colors.white, size: 22)
                      : Text(initials,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            name,
            style: TextStyle(
              fontSize: 11,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}