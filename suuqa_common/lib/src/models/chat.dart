import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuqa_common/src/apis/apis.dart';
import 'package:suuqa_common/src/models/product.dart';

class Chat {
  String chatID;
  Product product;
  List<dynamic> users = [];
  String imageURL;
  String type;
  var message;
  bool isTyping;
  Timestamp createdAt, updatedAt;

  Future<Chat> transform({String key, Map map}) async {
    Chat chat = new Chat();
    List<dynamic> users = map['users'];
    DocumentReference product = map['product'];

    chat.chatID = key;
    chat.product = await APIs().products.product(isSelling: true, productID: product.documentID);
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