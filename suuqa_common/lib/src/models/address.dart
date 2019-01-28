import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  String type, short, long, instructions;
  GeoPoint geoPoint;
  double distance;

  Address({this.type, this.short, this.long, this.instructions, this.geoPoint});

  Address transform({Map map}) {
    Address address = new Address();

    address.type = map['type'];
    address.short = map['short'];
    address.long = map["long"];
    address.instructions = map["instructions"];
    address.geoPoint = map['geoPoint'];

    return address;
  }

  GeoPoint toGeoPoint(double latitude, double longitude) {
    return GeoPoint(latitude, longitude);
  }

  Map<String, dynamic> toMap(Address a) {
    return {
      'type': a.type,
      'short': a.short,
      'long': a.long,
      'instructions': a.instructions,
      'geoPoint': a.geoPoint
    };
  }
}
