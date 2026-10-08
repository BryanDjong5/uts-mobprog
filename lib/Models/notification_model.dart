class AppNotification {
  final String id;
  final String title;
  final String body;
  final String type;
  final String? refId;
  final bool isRead;
  final DateTime createdAt;

  const AppNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.refId,
    required this.isRead,
    required this.createdAt,
  });

  AppNotification copyWith({bool? isRead}) {
    return AppNotification(
      id: id,
      title: title,
      body: body,
      type: type,
      refId: refId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt,
    );
  }
}
