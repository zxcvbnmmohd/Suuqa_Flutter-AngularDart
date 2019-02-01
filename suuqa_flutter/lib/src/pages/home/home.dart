import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/pages/home/tabs/account/account.dart';
import 'package:suuqa/src/pages/home/tabs/alerts/alerts.dart';
import 'package:suuqa/src/pages/home/tabs/chats/chats.dart';
import 'package:suuqa/src/pages/home/tabs/feed/feed.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_tabbar.dart';

class Home extends StatefulWidget {
  final String app;

  Home({this.app});

  static const String routeName = '/Home';

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin, RouteAware {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [];
    List<Widget> views = [];

    switch (InheritedUser.of(context).isLoggedIn) {
      case true:
        {
          items = [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Container(height: 0.0)),
            BottomNavigationBarItem(icon: Icon(Icons.chat), title: Container(height: 0.0)),
            BottomNavigationBarItem(icon: Icon(Icons.notifications), title: Container(height: 0.0)),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Container(height: 0.0)),
          ];
          views = [
            Feed(cUser: InheritedUser.of(context).user),
            Chats(cUser: InheritedUser.of(context).user),
            Alerts(cUser: InheritedUser.of(context).user),
            Account(cUser: InheritedUser.of(context).user),
          ];
        }
        break;
      case false:
        {
          items = [
            BottomNavigationBarItem(icon: Icon(Icons.home), title: Container(height: 0.0)),
            BottomNavigationBarItem(icon: Icon(Icons.person), title: Container(height: 0.0)),
          ];
          views = [
            Feed(),
            Account(),
          ];
        }
        break;
    }

    return PATabBar(
      items: items,
      backgroundColor: Config.bgColor,
      views: views,
    );
  }
}
