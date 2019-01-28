import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuqa_common/src/models/address.dart';

class Product {
  String productID, title, description, category, size;
  double total, deliveryFee, serviceFee, subtotal;
  int views;
  List<String> images = [];
  bool isSelling, forDelivery;
  Address address;
  Timestamp createdAt, updatedAt;
  DocumentReference user;

  Product transform({String key, Map map}) {
    Product product = new Product();
    List<dynamic> images = map['images'];

    product.productID = key;
    product.title = map['title'];
    product.description = map['description'];
    product.category = map['category'];
    product.total = double.parse(map['total'].toString());
    product.views = map['views'];

    images.forEach((image) {
      product.images.add(image);
    });

    product.address = Address().transform(map: map['address']);

    product.isSelling = map['isSelling'];
    product.forDelivery = map['forDelivery'];

    if (product.forDelivery) {
      Map<dynamic, dynamic> m = map['deliveryInfo'];
      product.size = m['size'];
      product.deliveryFee = double.parse(map['deliveryInfo']['deliveryFee'].toString());
      product.serviceFee = double.parse(m['serviceFee'].toString());
      product.subtotal = double.parse(map['deliveryInfo']['subtotal'].toString());
    }

    product.createdAt = map['createdAt'];
    product.updatedAt = map['updatedAt'];
    product.user = map['user'];

    return product;
  }
}