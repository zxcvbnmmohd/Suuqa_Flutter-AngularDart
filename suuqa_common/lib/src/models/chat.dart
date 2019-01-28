import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  String chatID;
  DocumentReference product;
  List<dynamic> users = [];
  String imageURL;
  String type;
  var message;
  bool isTyping;
  Timestamp createdAt, updatedAt;

  Chat transform({String key, Map map}) {
    Chat chat = new Chat();
    List<dynamic> users = map['users'];

    chat.chatID = key;
    chat.product = map['product'];
    chat.users = users;
    chat.imageURL = map['imageURL'];
    chat.type = map['type'];
    chat.message = map['message'];
    chat.isTyping = map['isTyping'];
    chat.createdAt = map['createdAt'];
    chat.updatedAt = map['updatedAt'];

    return chat;
  }
}