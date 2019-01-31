import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/auth/forgot.dart';
import 'package:suuqa/src/pages/home/home.dart';
import 'package:suuqa/src/widgets/essentials/button.dart';
import 'package:suuqa/src/widgets/essentials/text_view.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailTEC = TextEditingController();
  TextEditingController _passwordTEC = TextEditingController();
  FocusNode _emailFN = FocusNode();
  FocusNode _passwordFN = FocusNode();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    List<Widget> w = [
      Stack(
        children: <Widget>[
          Container(
            height: Platform.isIOS ? height - 140 : height,
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            margin: EdgeInsets.only(top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextView(
                  controller: this._emailTEC,
                  focusNode: this._emailFN,
                  hintText: 'Email',
                  hintStyle: TextStyle(
                    color: Config.tColor.withOpacity(0.5),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.none,
                  color: Config.tColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.left,
                  onSubmitted: (s) {
                    FocusScope.of(context).requestFocus(this._passwordFN);
                  },
                  keyboardAppearance: Brightness.light,
                ),
                TextView(
                  controller: this._passwordTEC,
                  focusNode: this._passwordFN,
                  hintText: 'Password',
                  hintStyle: TextStyle(
                    color: Config.tColor.withOpacity(0.5),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  color: Config.tColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.left,
                  obscureText: true,
                  onSubmitted: (s) {
                    Services().auth.login(
                        email: this._emailTEC.text,
                        password: this._passwordTEC.text,
                        onSuccess: () async {
                          InheritedUser.of(context).user = await APIs().users.cUser();
                          InheritedUser.of(context).isLoggedIn = true;
                          Functions.navigateAndReplaceWith(context: context, w: Home());
                        },
                        onFailure: (e) {
                          print(e);
                        });
                  },
                  keyboardAppearance: Brightness.dark,
                ),
                Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      GestureDetector(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Config.pColor, fontSize: 15, fontWeight: FontWeight.w500),
                          textAlign: TextAlign.right,
                        ),
                        onTap: () {
                          Functions.navigateTo(
                              context: context, w: Forgot(email: this._emailTEC.text), fullscreenDialog: false);
                        },
                      ),
                    ],
                  ),
                ),
                Button(
                  margin: EdgeInsets.only(bottom: 15.0),
                  text: 'Login',
                  color: Config.pColor,
                  outline: false,
                  onTap: () {
                    Services().auth.login(
                        email: this._emailTEC.text,
                        password: this._passwordTEC.text,
                        onSuccess: () async {
                          InheritedUser.of(context).user = await APIs().users.cUser();
                          InheritedUser.of(context).isLoggedIn = true;
                          Functions.navigateAndReplaceWith(context: context, w: Home());
                        },
                        onFailure: (e) {
                          print(e);
                        });
                  },
                ),
                FacebookSignInButton(
                    onPressed: () {
//                  Services().auth.loginWithFacebook(
//                        onLogin: () async {
//                          InheritedUser.of(context).user = await APIs().users.cUser();
//                          InheritedUser.of(context).isLoggedIn = true;
//                          Functions.navigateAndReplaceWith(context: context, w: Home());
//                        },
//                        onRegister: (user) {
////                          InheritedUser.of(context).user = await APIs().users.cUser();
////                          InheritedUser.of(context).isLoggedIn = true;
////                          Functions.navigateAndReplaceWith(context: context, w: Home());
//                        },
//                        onFailure: (e) {
//                          print(e);
//                        });
                }),
              ],
            ),
          )
        ],
      )
    ];

    return PAScaffold(
      iOSLargeTitle: true,
      color: Config.bgColor,
      title: 'Login',
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: Config.pColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[Container()],
      heroTag: 'Login',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }
}
