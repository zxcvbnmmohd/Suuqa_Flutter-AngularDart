import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Chats extends StatefulWidget {
  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  @override
  Widget build(BuildContext context) {
    List<Widget> w = [];

    return PAScaffold(
        iOSLargeTitle: true,
        color: Config.bgColor,
        title: 'Chats',
        leading: Platform.isIOS ? Container() : null,
        actions: Platform.isIOS ? <Widget>[Container()] : null,
        heroTag: 'Chats',
        androidView: ListView(children: w),
        iOSView: SliverList(delegate: SliverChildListDelegate(w)));
  }
}
