import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Buy extends StatefulWidget {
  @override
  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  Widget build(BuildContext context) {
    List<Widget> w = [];

    return PAScaffold(
        iOSLargeTitle: true,
        color: Config.bgColor,
        title: 'Buy',
        leading: IconButton(
            icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
            color: Config.tColor,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: Platform.isIOS ? <Widget>[Container()] : null,
        heroTag: 'Buy',
        androidView: ListView(children: w),
        iOSView: SliverList(delegate: SliverChildListDelegate(w)));
  }
}
