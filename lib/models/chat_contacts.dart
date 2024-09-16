class ChatContacts {
  final int id;
  final String name, email, image;
  final int unreadMessagesCount;

  ChatContacts({required this.id, required this.name, required this.unreadMessagesCount, required this.email, required this.image});


  factory ChatContacts.fromMap(Map<String, dynamic> map) {
    return ChatContacts(
      id: map['id'],
      name: map['name']??'',
      email: map['email']??'',
      image: map['image']??'',
      unreadMessagesCount: int.tryParse(map['unread_messages_count'].toString())??0,
    );
  }
}