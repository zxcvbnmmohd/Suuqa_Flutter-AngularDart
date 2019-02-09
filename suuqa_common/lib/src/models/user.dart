import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuqa_common/src/models/address.dart';

class User {
  String userID, aviURL, name, email, phone, role;
  List<Address> addresses = [];
  Count count;
  Timestamp createdAt, updatedAt;

  User transform({String key, Map map}) {
    User user = User();
    List<dynamic> addresses = map['addresses'];

    user.userID = key;
    user.aviURL = map['aviURL'];
    user.name = map['name'];
    user.email = map['email'];
    user.phone = map['phone'];
    user.role = map['role'];

    addresses.forEach((address) {
      user.addresses.add(Address().transform(map: address));
    });

    user.count = Count().transform(map: map['count']);

    user.createdAt = map['createdAt'];
    user.updatedAt = map['updatedAt'];

    return user;
  }
}

class Count {
  int products, services, sold;
  double rating;

  Count transform({Map map}) {
    Count count = Count();

    count.products = map['products'];
    count.services = map['services'];
    count.sold = map['sold'];
    count.rating = map['rating'].toDouble();

    return count;
  }
}