import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/essentials/button.dart';
import 'package:suuqa/src/widgets/essentials/text_view.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Forgot extends StatefulWidget {
  final String email;

  Forgot({this.email});

  @override
  _ForgotState createState() => _ForgotState();
}

class _ForgotState extends State<Forgot> {
  TextEditingController _emailTEC;

  @override
  void initState() {
    super.initState();
    this._emailTEC = new TextEditingController(text: widget.email);
  }

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
            margin: EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextView(
                  controller: this._emailTEC,
//                      focusNode: forgotBLoC.emailFN,
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
//                        onChanged: forgotBLoC.sinkEmail,
                  onSubmitted: (s) {},
                  keyboardAppearance: Brightness.light,
                ),
                Button(
                  margin: EdgeInsets.only(top: 15.0),
                  text: 'Send',
                  color: Config.pColor,
                  outline: false,
                  onTap: () {
//                    forgotBLoC.send(onSuccess: () {
//                      Navigator.pop(context);
//                    }, onFailure: (e) {
//                      print(e);
//                    });
                  },
                ),
              ],
            ),
          ),
        ],
      )
    ];

    return PAScaffold(
      iOSLargeTitle: true,
      color: Config.bgColor,
      title: 'Forgot Password',
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios,
          color: Config.pColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[Container()],
      heroTag: 'Forgot',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }

  // MARK - Functions

}
