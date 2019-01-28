import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/general/service.dart' as G;
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';

class ServiceItem extends StatelessWidget {
  final Service service;

  ServiceItem({this.service});

  @override
  Widget build(BuildContext context) {
    final cUser = InheritedUser.of(context).user;
    final nm    = NumberFormat("\$#,##0.00", "en_US");

    return GestureDetector(
      child: Container(
        height: 150.0,
        margin: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              height: 25.0,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Essay Writing',
                      style: TextStyle(color: Config.tColor, fontSize: 15.0, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    nm.format(40.00),
                    style: TextStyle(color: Config.tColor, fontSize: 15.0, fontWeight: FontWeight.w200),
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Config.wColor,
                  borderRadius: Config.borderRadius,
                ),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus consectetur mollis dolor quis sodales. Curabitur nec diam eu nisl interdum semper. Donec feugiat id erat eget pulvinar.',
                  style: TextStyle(color: Config.bgColor, fontWeight: FontWeight.w200),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
          User user = this.service.user.documentID == cUser.userID
              ? cUser
              : await APIs().users.user(userID: this.service.user.documentID);
          Functions.navigateTo(context: context, w: G.Service(service: this.service, user: user), fullscreenDialog: true);
      },
    );
  }
}
