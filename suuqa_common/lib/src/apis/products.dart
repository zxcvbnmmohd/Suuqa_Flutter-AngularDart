import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firestore_helpers/firestore_helpers.dart';
import 'package:suuqa_common/src/configs/config.dart';
import 'package:suuqa_common/src/models/product.dart';
import 'package:suuqa_common/src/services/services.dart';

class Products {
  final CollectionReference _productsSellingCollection = Firestore.instance.collection(Config.productsSelling);
  final CollectionReference _productsSoldCollection = Firestore.instance.collection(Config.productsSold);

  CollectionReference get productsSellingCollection {
    this._productsSellingCollection.firestore.settings(timestampsInSnapshotsEnabled: true);
    return this._productsSellingCollection;
  }
  CollectionReference get productsSoldCollection {
    this._productsSoldCollection.firestore.settings(timestampsInSnapshotsEnabled: true);
    return this._productsSoldCollection;
  }

  Future<Product> product({bool isSelling, String productID}) async {
    DocumentSnapshot ds = isSelling
        ? await this.productsSellingCollection.document(productID).get()
        : await this.productsSoldCollection.document(productID).get();
    return Product().transform(key: ds.documentID, map: ds.data);
  }

  observeProducts(
      {int limitTo,
      double priceMin,
      double priceMax,
      Function onEmpty,
      Function onAdded(Product p),
      Function onModified(Product p),
      Function onRemoved(Product p),
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this
            .productsSellingCollection
            .limit(limitTo)
            .where('total', isGreaterThanOrEqualTo: priceMin)
            .where('total', isLessThanOrEqualTo: priceMax)
            .snapshots(),
        onEmpty: () {
          onEmpty();
        },
        onAdded: (ds) {
          onAdded(Product().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) {
          onModified(Product().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) {
          onRemoved(Product().transform(key: ds.documentID, map: ds.data));
        },
        onFailure: (e) {
          onFailure(e);
        });
  }

  observeCategoryProducts(
      {String category,
      int limitTo,
      double priceMin,
      double priceMax,
      Function onEmpty,
      Function onAdded(Product p),
      Function onModified(Product p),
      Function onRemoved(Product p),
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this
            .productsSellingCollection
            .limit(limitTo)
            .where('category', isEqualTo: category)
            .where('total', isGreaterThanOrEqualTo: priceMin)
            .where('total', isLessThanOrEqualTo: priceMax)
            .snapshots(),
        onEmpty: () {
          onEmpty();
        },
        onAdded: (ds) {
          onAdded(Product().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) {
          onModified(Product().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) {
          onRemoved(Product().transform(key: ds.documentID, map: ds.data));
        },
        onFailure: (e) {
          onFailure(e);
        });
  }

  observeSearchProducts(
      {String title,
      int limitTo,
      double priceMin,
      double priceMax,
      Function onEmpty,
      Function onAdded(Product p),
      Function onModified(Product p),
      Function onRemoved(Product p),
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this
            .productsSellingCollection
            .limit(limitTo)
            .where('title', isEqualTo: title)
            .where('total', isGreaterThanOrEqualTo: priceMin)
            .where('total', isLessThanOrEqualTo: priceMax)
            .snapshots(),
        onEmpty: () {
          onEmpty();
        },
        onAdded: (ds) {
          onAdded(Product().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) {
          onModified(Product().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) {
          onRemoved(Product().transform(key: ds.documentID, map: ds.data));
        },
        onFailure: (e) {
          onFailure(e);
        });
  }

//  Stream<List<Product>> observeGeoProducts(
//      {GeoPoint geoPoint,
//      double radius,
//      int addressIndex,
//      double priceMin,
//      double priceMax,
//      int limitTo,
//      Function onEmpty,
//      Function onFailure(String e)}) {
//    return getDataInArea(
//        area: Area(geoPoint, radius),
//        source: this.productsSellingCollection,
//        mapper: (doc) {
//          return Product().transform(key: doc.documentID, map: doc.data);
//        },
//        locationFieldNameInDB: 'address.geoPoint',
//        locationAccessor: (product) => product.address.geoPoint,
//        distanceMapper: (product, distance) {
//          if (product != null) {
//            product.address.distance = distance;
//            return product;
//          } else {
//            onEmpty();
//          }
//        },
//        distanceAccessor: (product) => product.address.distance,
//        sortDecending: true,
//        serverSideConstraints: [
//          QueryConstraint(field: 'total', isGreaterThan: priceMin),
//          QueryConstraint(field: 'total', isLessThan: priceMax),
//        ]);
//  }
//
//  Stream<List<Product>> observeGeoCategoryProducts(
//      {GeoPoint geoPoint,
//      double radius,
//      String category,
//      double priceMin,
//      double priceMax,
//      int limitTo,
//      Function onEmpty,
//      Function onFailure(String e)}) {
//    return getDataInArea(
//        area: Area(geoPoint, radius),
//        source: this.productsSellingCollection.limit(limitTo),
//        mapper: (doc) {
//          return Product().transform(key: doc.documentID, map: doc.data);
//        },
//        locationFieldNameInDB: 'address.geopoint',
//        locationAccessor: (product) => product.address.geoPoint,
//        distanceMapper: (product, distance) {
//          if (product != null) {
//            product.address.distance = distance;
//            return product;
//          } else {
//            onEmpty();
//          }
//        },
//        distanceAccessor: (product) => product.address.distance,
//        sortDecending: true,
//        serverSideConstraints: [
//          QueryConstraint(field: 'category', isEqualTo: category),
//          QueryConstraint(field: 'total', isGreaterThan: priceMin),
//          QueryConstraint(field: 'total', isLessThan: priceMax),
//        ]);
//  }

  observeUserSellingProducts(
      {DocumentReference user,
      int limitTo,
      Function onAdded(Product p),
      Function onModified(Product p),
      Function onRemoved(Product p),
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this
            .productsSellingCollection
            .where('user', isEqualTo: user)
            .limit(limitTo)
            .snapshots(),
        onAdded: (ds) {
          onAdded(Product().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) {
          onModified(Product().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) {
          onRemoved(Product().transform(key: ds.documentID, map: ds.data));
        },
        onFailure: (e) {
          onFailure(e);
        });
  }

  observeUserSoldProducts(
      {DocumentReference user,
      int limitTo,
      Function onAdded(Product p),
      Function onModified(Product p),
      Function onRemoved(Product p),
      Function onFailure(String e)}) {
    Services().crud.readRT(
        query: this
            .productsSoldCollection
            .where('user', isEqualTo: user)
            .limit(limitTo)
            .snapshots(),
        onAdded: (ds) {
          onAdded(Product().transform(key: ds.documentID, map: ds.data));
        },
        onModified: (ds) {
          onModified(Product().transform(key: ds.documentID, map: ds.data));
        },
        onRemoved: (ds) {
          onRemoved(Product().transform(key: ds.documentID, map: ds.data));
        },
        onFailure: (e) {
          onFailure(e);
        });
  }
}
