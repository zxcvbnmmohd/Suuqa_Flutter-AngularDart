class Notification {
  String title, body;

  Notification transform({Map map}) {
    Notification notification = new Notification();

    notification.title = map['title'];
    notification.body = map['body'];

    return notification;
  }
}