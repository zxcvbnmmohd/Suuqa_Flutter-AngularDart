import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:suuqa_common/src/models/address.dart';

class User {
  String userID, aviURL, name, email, phone, role;
  List<Address> addresses = [];
  Timestamp createdAt, updatedAt;

  User transform({String key, Map map}) {
    User user = new User();
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

    user.createdAt = map['createdAt'];
    user.updatedAt = map['updatedAt'];

    return user;
  }
}