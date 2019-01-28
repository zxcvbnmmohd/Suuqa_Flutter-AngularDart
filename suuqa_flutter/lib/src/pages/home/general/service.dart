import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suuqa_common/suuqa_common.dart' as S;
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Service extends StatefulWidget {
  final S.Service service;
  final S.User user;

  Service({this.service, this.user});

  @override
  _ServiceState createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {
    final _ = NumberFormat("\$#,##0.00", "en_US");

    List<Widget> w = [];

    return PAScaffold(
      iOSLargeTitle: true,
      color: S.Config.bgColor,
      title: widget.service.title,
      leading: IconButton(
          icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
      actions: Platform.isIOS ? <Widget>[Container()] : null,
      heroTag: 'Service',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }
}
