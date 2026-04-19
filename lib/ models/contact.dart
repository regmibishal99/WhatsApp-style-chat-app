class Contact {
  final String id;
  final String name;
  final String avatarInitials;
  final int    avatarColorIndex;
  final String lastMessage;
  final DateTime lastMessageTime;
  final int    unreadCount;
  final bool   isOnline;
  final bool   isMuted;

  const Contact({
    required this.id,
    required this.name,
    required this.avatarInitials,
    required this.avatarColorIndex,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.unreadCount,
    required this.isOnline,
    this.isMuted = false,
  });
}