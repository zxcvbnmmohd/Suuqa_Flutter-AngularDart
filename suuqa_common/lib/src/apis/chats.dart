import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuqa_common/src/apis/apis.dart';
import 'package:suuqa_common/src/configs/config.dart';
import 'package:suuqa_common/src/models/chat.dart';
import 'package:suuqa_common/src/models/message.dart';
import 'package:suuqa_common/src/services/services.dart';

class Chats {
  final CollectionReference _chatsCollection = Firestore.instance.collection(Config.chats);

  CollectionReference get chatsCollection {
    this._chatsCollection.firestore.settings(timestampsInSnapshotsEnabled: true);
    return this._chatsCollection;
  }

  observeChats(
      {String userID,
      Function onAdded(Chat c),
      Function onModified(Chat c),
      Function onRemoved(Chat c),
      Function onEmpty,
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this.chatsCollection.where('users', arrayContains: Firestore.instance.document('users/$userID')).snapshots(),
        onAdded: (ds) async {
          onAdded(await Chat().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) async {
          onModified(await Chat().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) async {
          onRemoved(await Chat().transform(key: ds.documentID, map: ds.data));
        },
        onEmpty: () {
          onEmpty();
        },
        onFailure: (e) {
          onFailure(e);
        });
  }

  observeChat(
      {String productID,
      String userID,
      Function onAdded(Chat c),
      Function onModified(Chat c),
      Function onRemoved(Chat c),
      Function onEmpty,
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this
            .chatsCollection
            .where('product', isEqualTo: APIs().products.productsSellingCollection.document(productID))
            .where('users', arrayContains: APIs().users.usersCollection.document(userID))
            .snapshots(),
        onAdded: (ds) async {
          onAdded(await Chat().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) async {
          onModified(await Chat().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) async {
          onRemoved(await Chat().transform(key: ds.documentID, map: ds.data));
        },
        onEmpty: () {
          onEmpty();
        },
        onFailure: (e) {
          onFailure(e);
        });
  }

  observeMessages(
      {String chatID,
      Function onAdded(Message m),
      Function onModified(Message m),
      Function onRemoved(Message m),
      Function onEmpty,
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this.chatsCollection.document(chatID).collection(Config.messages).snapshots(),
        onAdded: (ds) {
          onAdded(Message().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) {
          onModified(Message().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) {
          onRemoved(Message().transform(key: ds.documentID, map: ds.data));
        },
        onEmpty: () {
          onEmpty();
        },
        onFailure: (e) {
          onFailure(e);
        });
  }
}
