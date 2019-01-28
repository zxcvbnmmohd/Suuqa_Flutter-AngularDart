import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart' as S;
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/auth/login.dart';
import 'package:suuqa/src/pages/auth/register/address.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    List<Widget> w = [];

    InheritedUser.of(context).isLoggedIn
        ? w = [
            SizedBox(height: 25.0),
          ]
        : w = [
            SizedBox(height: 25.0),
            this._tile(
                title: 'Login',
                subTitle: '',
                icon: Icon(Icons.navigate_next, color: S.Config.bgColor),
                onTap: () {
                  Functions.navigateTo(context: context, w: Login(), fullscreenDialog: true);
                }),
            this._tile(
                title: 'Register',
                subTitle: '',
                icon: Icon(Icons.navigate_next, color: S.Config.bgColor),
                onTap: () {
                  Functions.navigateTo(context: context, w: Address(), fullscreenDialog: true);
                }),
          ];

    return PAScaffold(
        iOSLargeTitle: true,
        color: S.Config.bgColor,
        title: 'Account',
        leading: Platform.isIOS ? Container() : null,
        actions: Platform.isIOS ? <Widget>[Container()] : null,
        heroTag: 'Account',
        androidView: ListView(children: w),
        iOSView: SliverList(delegate: SliverChildListDelegate(w)));
  }

  Widget _tile({String title, String subTitle, Widget icon, Function onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: S.Config.wColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      margin: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0),
      child: ListTile(
        title: Text(title, style: TextStyle(color: S.Config.bgColor)),
        subtitle: subTitle.length == 0 ? null : Text(subTitle, style: TextStyle(color: S.Config.bgColor)),
        trailing: icon,
        onTap: onTap,
      ),
    );
  }
}
