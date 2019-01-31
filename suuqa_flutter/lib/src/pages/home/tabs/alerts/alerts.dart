import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Alerts extends StatefulWidget {
  final User cUser;

  Alerts({this.cUser});

  @override
  _AlertsState createState() => _AlertsState();
}

class _AlertsState extends State<Alerts> {
  @override
  Widget build(BuildContext context) {
    List<Widget> w = [];

    return PAScaffold(
        iOSLargeTitle: true,
        color: Config.bgColor,
        title: 'Alerts',
        leading: Platform.isIOS ? Container() : null,
        actions: Platform.isIOS ? <Widget>[Container()] : null,
        heroTag: 'Alerts',
        androidView: ListView(children: w),
        iOSView: SliverList(delegate: SliverChildListDelegate(w)));
  }
}
