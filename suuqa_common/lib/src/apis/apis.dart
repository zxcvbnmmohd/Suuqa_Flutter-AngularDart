import 'package:suuqa_common/src/apis/alerts.dart';
import 'package:suuqa_common/src/apis/algolia.dart';
import 'package:suuqa_common/src/apis/chats.dart';
import 'package:suuqa_common/src/apis/orders.dart';
import 'package:suuqa_common/src/apis/products.dart';
import 'package:suuqa_common/src/apis/requests.dart';
import 'package:suuqa_common/src/apis/users.dart';

class APIs {
  Alerts alerts = new Alerts();
  Algolia algolia = new Algolia();
  Chats chats = new Chats();
  Orders orders = new Orders();
  Products products = new Products();
  Requests requests = new Requests();
  Users users = new Users();
}