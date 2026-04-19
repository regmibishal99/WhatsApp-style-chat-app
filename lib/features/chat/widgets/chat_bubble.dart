import 'package:flutter/material.dart';
import 'package:whatsappchatapp/%20models/message.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/time_formatter.dart';
import '../../../models/message.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final bool    showTail;

  const ChatBubble({
    super.key,
    required this.message,
    required this.showTail,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isMine = message.isSentByMe;

    final bgColor = isMine
        ? (isDark ? AppTheme.sentBubbleDark : AppTheme.lightGreen)
        : (isDark ? AppTheme.recvBubbleDark : AppTheme.recvBubbleLight);

    final textColor = isDark ? Colors.white : Colors.black87;

    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          top: 2, bottom: 2,
          left:  isMine ? 60 : 4,
          right: isMine ? 4  : 60,
        ),
        child: CustomPaint(
          painter: showTail ? _BubbleTailPainter(isMine: isMine, color: bgColor) : null,
          child: Container(
            padding: const EdgeInsets.only(
                left: 10, right: 10, top: 7, bottom: 5),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                topLeft:     const Radius.circular(10),
                topRight:    const Radius.circular(10),
                bottomLeft:  Radius.circular(isMine ? 10 : (showTail ? 0 : 10)),
                bottomRight: Radius.circular(isMine ? (showTail ? 0 : 10) : 10),
              ),
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 1)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Deleted message
                if (message.isDeleted)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.block, size: 14,
                          color: isDark ? Colors.white38 : Colors.black38),
                      const SizedBox(width: 4),
                      Text('This message was deleted',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                            color: isDark ? Colors.white38 : Colors.black38,
                            fontSize: 13,
                          )),
                    ],
                  )
                else
                  // Message text with intrinsic spacing for time
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 52),
                        child: Text(
                          message.text,
                          style: TextStyle(
                            fontSize: 14.5,
                            color: textColor,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                // Time + status row
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      TimeFormatter.bubbleTime(message.timestamp),
                      style: TextStyle(
                        fontSize: 11,
                        color: isDark ? Colors.white38 : Colors.black38,
                      ),
                    ),
                    if (isMine) ...[
                      const SizedBox(width: 3),
                      Icon(
                        message.status == MessageStatus.read
                            ? Icons.done_all
                            : message.status == MessageStatus.delivered
                                ? Icons.done_all
                                : Icons.done,
                        size: 15,
                        color: message.status == MessageStatus.read
                            ? AppTheme.readColor
                            : (isDark ? Colors.white38 : Colors.black38),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Draws the little tail on the last bubble in a group
class _BubbleTailPainter extends CustomPainter {
  final bool  isMine;
  final Color color;

  const _BubbleTailPainter({required this.isMine, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path  = Path();

    if (isMine) {
      path
        ..moveTo(size.width - 6, size.height)
        ..lineTo(size.width + 6, size.height + 8)
        ..lineTo(size.width - 6, size.height - 6)
        ..close();
    } else {
      path
        ..moveTo(6, size.height)
        ..lineTo(-6, size.height + 8)
        ..lineTo(6, size.height - 6)
        ..close();
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_BubbleTailPainter old) =>
      old.isMine != isMine || old.color != color;
}