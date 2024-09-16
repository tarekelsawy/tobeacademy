import 'package:icourseapp/main.dart';

class ChatItem {
  final int senderId;
  final int? id;
  final String message;
  final MessageAttachment? attachement;
  final DateTime? createdAt;

  bool get isAttachImage =>  attachement != null && attachement!.mimeType.contains('image');

  bool get isMe => senderId == pref.client?.id;
  ChatItem({required this.senderId, required this.message, this.createdAt, this.id, this.attachement});


  factory ChatItem.fromMap(Map<String, dynamic> map) {
    return ChatItem(
      senderId: int.parse(map['sender_id'].toString()),
      message: map['message'],
      attachement: map['attachement'] == null? null: MessageAttachment.fromMap(map['attachement']),
      id: map['id'],
      createdAt: map['created_at'] == null? null:DateTime.parse(map['created_at']),
    );
  }
}

class MessageAttachment {
  final int? id;
  final String fileName;
  final String filePath,mimeType;

  MessageAttachment({required this.fileName, required this.filePath, required this.id, required this.mimeType});


  factory MessageAttachment.fromMap(Map<String, dynamic> map) {
    return MessageAttachment(
      fileName: map['file_name'],
      id: map['id'],
      mimeType: map['mime_type'],
      filePath: map['file_path'],
    );
  }
}