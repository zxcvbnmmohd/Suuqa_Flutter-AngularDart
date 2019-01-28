import 'package:suuqa_common/src/services/analytics.dart';
import 'package:suuqa_common/src/services/auth.dart';
import 'package:suuqa_common/src/services/crud.dart';
import 'package:suuqa_common/src/services/messaging.dart';
import 'package:suuqa_common/src/services/storage.dart';

class Services {
  Analytics analytics = Analytics();
  Auth auth = Auth();
  CRUD crud = CRUD();
  Messaging messaging = Messaging();
  Storage storage = Storage();
}