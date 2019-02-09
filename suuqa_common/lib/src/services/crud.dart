import 'package:cloud_firestore/cloud_firestore.dart';

class CRUD {
  create({DocumentReference ref, Map map, Function onSuccess, Function onFailure(String e)}) {
    ref.setData(map).whenComplete(() {
      onSuccess();
    }).catchError((e) {
      onFailure(e.toString());
    });
  }

  read({DocumentReference ref, Future<Function> onSuccess(DocumentSnapshot d), Future<Function> onFailure(String e)}) {
    ref.get().then((snapshot) {
      onSuccess(snapshot);
    }).catchError((e) {
      onFailure(e.toString());
    });
  }

  readRT(
      {Stream query,
      Function onEmpty,
      Future<Function> onAdded(DocumentSnapshot d),
      Future<Function> onModified(DocumentSnapshot d),
      Future<Function> onRemoved(DocumentSnapshot d),
      Function onFailure(String e)}) {
    query.listen((data) {
      if (data.documents.isEmpty) {
        onEmpty;
      } else {
        data.documentChanges.forEach((change) {
          if (change.type == DocumentChangeType.added) {
            onAdded(change.document);
          }
          if (change.type == DocumentChangeType.modified) {
            onModified(change.document);
          }
          if (change.type == DocumentChangeType.removed) {
            onRemoved(change.document);
          }
        });
      }
    }, onError: (e) {
      onFailure(e.toString());
      return;
    });
  }

  readChange(
      {QuerySnapshot data,
      Function onEmpty(),
      Future<Function> onAdded(DocumentSnapshot d),
      Future<Function> onModified(DocumentSnapshot d),
      Future<Function> onRemoved(DocumentSnapshot d)}) {
    if (data.documents.isEmpty) {
      onEmpty();
    } else {
      data.documentChanges.forEach((change) {
        if (change.type == DocumentChangeType.added) {
          onAdded(change.document);
        }
        if (change.type == DocumentChangeType.modified) {
          onModified(change.document);
        }
        if (change.type == DocumentChangeType.removed) {
          onRemoved(change.document);
        }
      });
    }
  }

  update({DocumentReference ref, Map map, Function onSuccess, Function onFailure(String e)}) {
    ref.updateData(map).whenComplete(() {
      onSuccess();
    }).catchError((e) {
      onFailure(e.toString());
    });
  }

  delete({DocumentReference ref, Function onSuccess, Function onFailure(String e)}) {
    ref.delete().whenComplete(() {
      onSuccess();
    }).catchError((e) {
      onFailure(e.toString());
    });
  }
}
