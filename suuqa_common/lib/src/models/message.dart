import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String messageID;
  DocumentReference user;
  String type;
  var message;
  bool isRead;
  Timestamp createdAt;

  Message transform({String key, Map map}) {
    Message message = new Message();

    message.messageID = key;
    message.user = map['user'];
    message.type = map['type'];
    message.message = map['message'];
    message.isRead = map['isRead'];
    message.createdAt = map['createdAt'];

    return message;
  }
}