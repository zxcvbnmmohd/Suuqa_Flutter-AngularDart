import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/home.dart';
import 'package:suuqa/src/widgets/essentials/button.dart';
import 'package:suuqa/src/widgets/essentials/text_view.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Password extends StatefulWidget {
  final Address address;
  final File photo;
  final String name, email, phone;

  Password({this.address, this.photo, this.name, this.email, this.phone});

  @override
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  TextEditingController _passwordTEC = new TextEditingController();
  FocusNode _passwordFN = new FocusNode();

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
            padding: EdgeInsets.only(left: 25.0, top: 15.0, right: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextView(
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
                        autoFocus: true,
                        obscureText: true,
                        onSubmitted: (s) {},
                        keyboardAppearance: Brightness.dark,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Column(
                  children: <Widget>[
                    Text(
                      'By registering, you agree to the ',
                      style: TextStyle(color: Colors.black54),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            child: Text(
                              'Terms of Service',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            onTap: () {}),
                        Text(
                          ' and ',
                          style: TextStyle(color: Colors.black54),
                        ),
                        GestureDetector(
                            child: Text(
                              'Privacy Policy',
                              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                            ),
                            onTap: () {}),
                        Text(
                          '.',
                          style: TextStyle(color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
                Button(
                  margin: EdgeInsets.only(top: 15.0),
                  text: 'Register',
                  color: Config.pColor,
                  outline: false,
                  onTap: () {
                    Services().auth.register(
                        m: <String, dynamic>{
                          'name': widget.name,
                          'email': widget.email,
                          'phone': widget.phone,
                          'addresses': [
                            Address().toMap(widget.address),
                          ],
                          'role': 'customer',
                          'createdAt': DateTime.now(),
                          'updatedAt': DateTime.now()
                        },
                        password: this._passwordTEC.text,
                        onSuccess: (u) {
                          Services().storage.upload(
                              path: 'users/${u.uid}/profile/avi',
                              file: widget.photo,
                              onSuccess: (url) {
                                Services().crud.update(
                                    ref: APIs().users.usersCollection.document(u.uid),
                                    map: <String, dynamic>{
                                      'aviURL' : url
                                    },
                                    onSuccess: () async {
                                      InheritedUser.of(context).user = await APIs().users.cUser();
                                      InheritedUser.of(context).isLoggedIn = true;
                                      Functions.navigateAndReplaceWith(context: context, w: Home());
                                    },
                                    onFailure: (e) {
                                      print(e);
                                    });
                              },
                              onFailure: (e) {
                                print(e);
                              });
                        },
                        onFailure: (e) {
                          print(e);
                        });
                  },
                ),
              ],
            ),
          )
        ],
      )
    ];

    return PAScaffold(
      iOSLargeTitle: true,
      color: Config.bgColor,
      title: 'Password',
      leading: IconButton(
        icon: Icon(
          Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
          color: Config.pColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[Container()],
      heroTag: 'Password',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }

  // MARK - Functions


}
