class Alert {
  String alertID;
  String type;

  Alert transform({String key, Map map}) {
    Alert a = new Alert();

    a.alertID = key;
    a.type = map['type'];

    return a;
  }
}