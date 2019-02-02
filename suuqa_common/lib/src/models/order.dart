import 'package:cloud_firestore/cloud_firestore.dart';

class Order {
  String orderID;
  DocumentReference product, request, user;
  Timestamp timestamp;

  Order transform({String key, Map map}) {
    Order order = new Order();

    order.orderID = key;
    order.product = map['product'];
    order.request = map['request'];
    order.user = map['user'];
    order.timestamp = map['timestamp'];

    return order;
  }
}