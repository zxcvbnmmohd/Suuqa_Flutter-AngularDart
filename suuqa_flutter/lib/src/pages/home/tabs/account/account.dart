import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/home.dart';
import 'package:suuqa/src/pages/auth/login.dart';
import 'package:suuqa/src/pages/auth/register/address.dart' as A;
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Account extends StatefulWidget {
  final User cUser;

  Account({this.cUser});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final cUser = InheritedUser.of(context);
    List<Widget> w = cUser.isLoggedIn
        ? [
            SizedBox(height: 25.0),
            this._tile(title: cUser.user.name, subTitle: '', icon: Icon(Icons.person)),
            this._tile(
                title: 'Logout',
                subTitle: '',
                icon: Icon(Icons.navigate_next, color: Config.bgColor),
                onTap: () {
                  Services().auth.logout(onSuccess: () {
                    cUser.isLoggedIn = false;
                    cUser.user = null;
                    Functions.navigateAndReplaceWith(context: context, w: Home());
                  }, onFailure: (e) {
                    print(e);
                  });
                }),
          ]
        : [
            SizedBox(height: 25.0),
            this._tile(
                title: 'Login',
                subTitle: '',
                icon: Icon(Icons.navigate_next, color: Config.bgColor),
                onTap: () {
                  Functions.navigateTo(context: context, w: Login(), fullscreenDialog: true);
                }),
            this._tile(
                title: 'Register',
                subTitle: '',
                icon: Icon(Icons.navigate_next, color: Config.bgColor),
                onTap: () {
                  Functions.navigateTo(context: context, w: A.Address(), fullscreenDialog: true);
                }),
          ];

    return PAScaffold(
        iOSLargeTitle: true,
        color: Config.bgColor,
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
        color: Config.wColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      margin: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Config.bgColor)),
        subtitle: subTitle.length == 0 ? null : Text(subTitle, style: TextStyle(color: Config.bgColor)),
        trailing: icon,
        onTap: onTap,
      ),
    );
  }
}
