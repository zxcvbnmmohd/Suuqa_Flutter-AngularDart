import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuqa_common/src/configs/config.dart';
import 'package:suuqa_common/src/models/user.dart';
import 'package:suuqa_common/src/models/card.dart';
import 'package:suuqa_common/src/services/services.dart';

class Users {
  final CollectionReference _usersCollection = Firestore.instance.collection(Config.users);

  CollectionReference get usersCollection {
    this._usersCollection.firestore.settings(timestampsInSnapshotsEnabled: true);
    return this._usersCollection;
  }

  cUserDocument() async {
    String userID = (await Services().auth.auth.currentUser()).uid;
    return this.usersCollection.document(userID).get();
  }

  Future<User> cUser() async {
    DocumentSnapshot ds = await this.cUserDocument();
    return User().transform(key: ds.documentID, map: ds.data);
  }

  usersRef({String userID}) async {
    return this.usersCollection.document(userID).get();
  }

  user({String userID}) async {
    DocumentSnapshot ds = await this.usersRef(userID: userID);
    return User().transform(key: ds.documentID, map: ds.data);
  }

  currentUserCards({String userID, Function onAdded(Card c), Function onModified(Card c), Function onRemoved(Card c), Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this.usersCollection
            .document(userID)
            .collection('payments')
            .document('stripe')
            .collection('sources')
            .snapshots(),
        onAdded: (ds) {
          onAdded(Card().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) {
          onAdded(Card().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) {
          onAdded(Card().transform(key: ds.documentID, map: ds.data));
        },
        onFailure: (e) {
          onFailure(e);
        });
  }
}