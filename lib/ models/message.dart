enum MessageStatus { sent, delivered, read }
enum MessageType   { text, image, audio, document }

class Message {
  final String        id;
  final String        text;
  final bool          isSentByMe;
  final DateTime      timestamp;
  final MessageStatus status;
  final MessageType   type;
  final bool          isDeleted;
  final String?       replyTo;

  const Message({
    required this.id,
    required this.text,
    required this.isSentByMe,
    required this.timestamp,
    required this.status,
    this.type      = MessageType.text,
    this.isDeleted = false,
    this.replyTo,
  });
}