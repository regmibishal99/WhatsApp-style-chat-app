import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/time_formatter.dart';
import '../../../data/chat_data.dart';
import '../../../models/contact.dart';
import '../../../models/message.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_input_bar.dart';

class ChatScreen extends StatefulWidget {
  final Contact contact;
  const ChatScreen({super.key, required this.contact});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late List<Message> _messages;
  final _scrollCtrl = ScrollController();
  final _inputCtrl  = TextEditingController();
  bool _showScrollDown = false;

  @override
  void initState() {
    super.initState();
    _messages = List.from(ChatData.allMessages[widget.contact.id] ?? []);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    _scrollCtrl.addListener(() {
      final isAtBottom = _scrollCtrl.position.pixels >=
          _scrollCtrl.position.maxScrollExtent - 100;
      if (isAtBottom != !_showScrollDown) {
        setState(() => _showScrollDown = !isAtBottom);
      }
    });
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    _inputCtrl.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollCtrl.hasClients) {
      _scrollCtrl.animateTo(
        _scrollCtrl.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    final text = _inputCtrl.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(Message(
        id:          'new_${DateTime.now().millisecondsSinceEpoch}',
        text:        text,
        isSentByMe:  true,
        timestamp:   DateTime.now(),
        status:      MessageStatus.sent,
      ));
    });
    _inputCtrl.clear();
    Future.delayed(const Duration(milliseconds: 100), _scrollToBottom);
  }

  /// Group messages by date for dividers
  bool _showDateDivider(int index) {
    if (index == 0) return true;
    final cur  = _messages[index].timestamp;
    final prev = _messages[index - 1].timestamp;
    return cur.day != prev.day ||
        cur.month != prev.month ||
        cur.year  != prev.year;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.bgDark : const Color(0xFFE5DDD5),
      appBar: ChatAppBar(contact: widget.contact),
      body: Stack(
        children: [
          // Wallpaper-style subtle pattern
          Positioned.fill(
            child: Opacity(
              opacity: isDark ? 0.03 : 0.06,
              child: Image.network(
                'https://www.transparenttextures.com/patterns/dark-mosaic.png',
                repeat: ImageRepeat.repeat,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
            ),
          ),
          Column(
            children: [
              // Message list
              Expanded(
                child: ListView.builder(
                  controller: _scrollCtrl,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 8),
                  itemCount: _messages.length,
                  itemBuilder: (context, i) {
                    final msg = _messages[i];
                    return Column(
                      children: [
                        if (_showDateDivider(i))
                          _DateDivider(
                              label: TimeFormatter.dateDivider(
                                  msg.timestamp)),
                        ChatBubble(
                          message:  msg,
                          showTail: i == _messages.length - 1 ||
                              _messages[i + 1].isSentByMe !=
                                  msg.isSentByMe,
                        ),
                      ],
                    );
                  },
                ),
              ),
              // Input bar
              ChatInputBar(
                controller: _inputCtrl,
                onSend: _sendMessage,
              ),
            ],
          ),
          // Scroll to bottom FAB
          if (_showScrollDown)
            Positioned(
              right: 12,
              bottom: 72,
              child: GestureDetector(
                onTap: _scrollToBottom,
                child: Container(
                  width: 38, height: 38,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppTheme.surfaceDark
                        : Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 6)
                    ],
                  ),
                  child: const Icon(Icons.keyboard_arrow_down,
                      color: Colors.grey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _DateDivider extends StatelessWidget {
  final String label;
  const _DateDivider({required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: isDark
                ? const Color(0xFF182229)
                : const Color(0xFFD9FDD3),
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 2)
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ),
      ),
    );
  }
}