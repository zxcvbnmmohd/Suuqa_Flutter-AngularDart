import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuqa_common/src/models/address.dart';

class Request {
  String requestID, deliveryTime, paymentMethod;
  DocumentReference user, product;
  Address addressFrom, addressTo;
  double shipping, total;
  Timestamp createdAt;

  Request transform({String key, Map map}) {
    Request request = new Request();
    Map<dynamic, dynamic> addresses = map['addresses'];

    request.requestID = key;
    request.user = map['user'];
    request.product = map['product'];
    request.deliveryTime = map['deliveryTime'];

    addresses.forEach((key, m) {
      if (key == 'from') {
        request.addressFrom = Address().transform(map: m);
      }
      if (key == 'to') {
        request.addressTo = Address().transform(map: m);
      }
    });

    request.paymentMethod = map['paymentMethod'];
    request.shipping = map['shipping'];
    request.total = map['total'];
    request.createdAt = map['timestamp'];

    return request;
  }
}