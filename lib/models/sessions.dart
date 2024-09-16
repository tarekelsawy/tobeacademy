class Sessions{
  final int id, userId;
  final String title, token, channel;
  final DateTime classDate;

  Sessions({required this.id, required this.title, required this.token, required this.channel, required this.classDate, required this.userId});


  factory Sessions.fromMap(Map<String, dynamic> map) {
    return Sessions(
      id: map['id'],
      title: map['title'],
      token: map['token'],
      userId: map['user_id'],
      channel: map['channel'],
      classDate: map['class_date'] == null? DateTime.now(): DateTime.parse(map['class_date']),
    );
  }
}