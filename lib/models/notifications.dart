class Notifications {
  final String subject, message;
  final String id;
  final DateTime createdAt;
  final String? readAt;

  bool get isRead => readAt != null;

  Notifications(
      {required this.subject,
      required this.message,
      required this.id,
      required this.createdAt,
      required this.readAt});

  factory Notifications.fromMap(Map<String, dynamic> map) {
    return Notifications(
      subject: map['data']['title'],
      message: map['data']['body'],
      id: map['id'],
      createdAt: map['created_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['created_at'].toString()),
      readAt: map['read_at'],
    );
  }
}
