import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuqa_common/src/configs/config.dart';
import 'package:suuqa_common/src/models/request.dart';
import 'package:suuqa_common/src/services/services.dart';

class Requests {
  final CollectionReference _requestsCollection = Firestore.instance.collection(Config.requests);

  CollectionReference get requestsCollection {
    this._requestsCollection.firestore.settings(timestampsInSnapshotsEnabled: true);
    return this._requestsCollection;
  }

  currentRequests({DocumentReference user, Function onAdded(Request r), Function onModified(Request r), Function onRemoved(Request r), Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this.requestsCollection
            .where('user', isEqualTo: user)
            .snapshots(),
        onAdded: (ds) {
          onAdded(Request().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) {
          onAdded(Request().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) {
          onAdded(Request().transform(key: ds.documentID, map: ds.data));
        },
        onFailure: (e) {
          onFailure(e);
        });
  }

}