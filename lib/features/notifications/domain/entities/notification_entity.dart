class NotificationEntity {
  final String id;
  final String teamId;
  final String inviteId;
  final String message;
  final bool isRead;

  NotificationEntity({
    required this.id,
    required this.teamId,
    required this.inviteId,
    required this.message,
    this.isRead = false,
  });

  NotificationEntity copyWith({
    String? id,
    String? teamId,
    String? inviteId,
    String? message,
    bool? isRead,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      teamId: teamId ?? this.teamId,
      inviteId: inviteId ?? this.inviteId,
      message: message ?? this.message,
      isRead: isRead ?? this.isRead,
    );
  }
}
