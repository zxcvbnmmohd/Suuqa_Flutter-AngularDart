import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuqa_common/src/configs/config.dart';
import 'package:suuqa_common/src/models/alert.dart';
import 'package:suuqa_common/src/services/services.dart';

class Alerts {
  final CollectionReference _alertsCollection = Firestore.instance.collection(Config.alerts);

  CollectionReference get alertsCollection => this._alertsCollection;

  observeAlerts({int limitTo, Function onAdded(Alert a),Function onModified(Alert a), Function onRemoved(Alert a), Function onEmpty, Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this.alertsCollection.limit(limitTo).snapshots(),
        onAdded: (ds) {
          onAdded(Alert().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) {
          onModified(Alert().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) {
          onRemoved(Alert().transform(key: ds.documentID, map: ds.data));
        },
        onEmpty: () {
          onEmpty();
        },
        onFailure: (e) {
          onFailure(e);
        });
  }
}