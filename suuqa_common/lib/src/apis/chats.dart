import 'package:flutter/material.dart';
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
      Function onEmpty,
      Function onAdded(Chat c),
      Function onModified(Chat c),
      Function onRemoved(Chat c),
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this.chatsCollection.where('users', arrayContains: Firestore.instance.document('users/$userID')).snapshots(),
        onEmpty: () {
          onEmpty();
        },
        onAdded: (ds) async {
          onAdded(await Chat().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) async {
          onModified(await Chat().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) async {
          onRemoved(await Chat().transform(key: ds.documentID, map: ds.data));
        },
        onFailure: (e) {
          onFailure(e);
        });
  }

  observeChat(
      {String productID,
      String userID,
      Function onEmpty,
      Function onAdded(Chat c),
      Function onModified(Chat c),
      Function onRemoved(Chat c),
      Function onSuccess(Chat c),
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this
            .chatsCollection
            .limit(1)
            .where('product', isEqualTo: APIs().products.productsSellingCollection.document(productID))
            .where('users', arrayContains: APIs().users.usersCollection.document(userID))
            .snapshots(),
        onEmpty: () {
          onEmpty();
        },
        onAdded: (ds) async {
          onAdded(await Chat().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) async {
          onModified(await Chat().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) async {
          onRemoved(await Chat().transform(key: ds.documentID, map: ds.data));
        },
        onFailure: (e) {
          onFailure(e);
        });
  }

  observeMessages(
      {String chatID,
      Function onEmpty(),
      Function onAdded(Message m),
      Function onModified(Message m),
      Function onRemoved(Message m),
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this.chatsCollection.document(chatID).collection(Config.messages).snapshots(),
        onEmpty: () {
          onEmpty();
        },
        onAdded: (ds) async {
          onAdded(Message().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) async {
          onModified(Message().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) async {
          onRemoved(Message().transform(key: ds.documentID, map: ds.data));
        },
        onFailure: (e) {
          onFailure(e);
        });
  }

  StreamBuilder<QuerySnapshot> observeMessagesStream(
      {String chatID,
      Function onEmpty,
      Function onAdded(Message m),
      Function onModified(Message m),
      Function onRemoved(Message m),
      onDefault()}) {
    return StreamBuilder<QuerySnapshot>(
      stream: this.chatsCollection.document(chatID).collection(Config.messages).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');

        if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Text('Loading...');
            default:
              {
                Services().crud.readChange(
                  data: snapshot.data,
                  onEmpty: () {
                    onEmpty;
                  },
                  onAdded: (ds) async {
                    onAdded(Message().transform(key: ds.documentID, map: ds.data));
                  },
                  onModified: (ds) async {
                    onModified(Message().transform(key: ds.documentID, map: ds.data));
                  },
                  onRemoved: (ds) async {
                    onRemoved(Message().transform(key: ds.documentID, map: ds.data));
                  },
                );
                return onDefault();
              }
          }
        } else {
          return Container();
        }
      },
    );
  }
}
