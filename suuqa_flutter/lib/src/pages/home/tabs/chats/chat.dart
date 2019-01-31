import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart' as S;
import 'package:suuqa/src/pages/home/tabs/chats/inner_chat/buy.dart';
import 'package:suuqa/src/pages/home/tabs/chats/inner_chat/messages.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Chat extends StatefulWidget {
  final S.Product product;

  Chat({this.product});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    final S.User cUser = InheritedUser.of(context).user;

    Widget w = widget.product.forDelivery
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              backgroundColor: S.Config.bgColor,
              appBar: TabBar(
                tabs: [
                  Tab(text: 'Messages'),
                  Tab(text: 'Buy Now'),
                ],
                indicatorColor: S.Config.pColor,
                labelColor: S.Config.tColor,
              ),
              body: TabBarView(children: [
                Messages(product: widget.product, cUser: cUser),
                Buy(),
              ]),
            ),
          )
        : Messages(product: widget.product, cUser: cUser);

    return PAScaffold(
        iOSLargeTitle: false,
        color: S.Config.bgColor,
        title: 'Chat',
        leading: IconButton(
            icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: Platform.isIOS ? <Widget>[Container()] : null,
        heroTag: 'Chat',
        androidView: w,
        iOSView: w);
  }
}
