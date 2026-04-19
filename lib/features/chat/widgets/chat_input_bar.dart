import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class ChatInputBar extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;

  const ChatInputBar({
    super.key,
    required this.controller,
    required this.onSend,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(
      () => setState(() => _hasText = widget.controller.text.trim().isNotEmpty),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      color: isDark ? AppTheme.bgDark : const Color(0xFFE5DDD5),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Text field
            Expanded(
              child: Container(
                constraints: const BoxConstraints(minHeight: 44, maxHeight: 120),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.surfaceDark : Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Emoji icon
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Icon(Icons.emoji_emotions_outlined,
                          color: isDark ? Colors.white38 : Colors.black38,
                          size: 24),
                    ),
                    // Text input
                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textCapitalization: TextCapitalization.sentences,
                        style: TextStyle(
                          fontSize: 15,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Message',
                          hintStyle: TextStyle(
                            color: isDark ? Colors.white38 : Colors.black38,
                            fontSize: 15,
                          ),
                          border:  InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 11, horizontal: 8),
                        ),
                      ),
                    ),
                    // Attach + Camera icons (when no text)
                    if (!_hasText) ...[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Icon(Icons.attach_file,
                            color: isDark ? Colors.white38 : Colors.black38,
                            size: 22),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 10, bottom: 10),
                        child: Icon(Icons.camera_alt_outlined,
                            color: isDark ? Colors.white38 : Colors.black38,
                            size: 22),
                      ),
                    ] else
                      const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 6),
            // Send / Mic button
            GestureDetector(
              onTap: _hasText ? widget.onSend : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 46, height: 46,
                decoration: const BoxDecoration(
                  color: AppTheme.primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: Icon(
                    _hasText ? Icons.send : Icons.mic,
                    key: ValueKey(_hasText),
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}