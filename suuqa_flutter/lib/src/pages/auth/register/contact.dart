import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/auth/register/password.dart';
import 'package:suuqa/src/widgets/essentials/button.dart';
import 'package:suuqa/src/widgets/essentials/text_view.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Contact extends StatefulWidget {
  final Address address;
  final File photo;
  final String name;

  Contact({this.address, this.photo, this.name});

  @override
  _ContactState createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  TextEditingController _emailTEC = TextEditingController();
  TextEditingController _areaCodeTEC = TextEditingController(text: '+1');
  TextEditingController _phoneTEC = MaskedTextController(mask: '(000) 000-0000');
  FocusNode _emailFN = FocusNode();
  FocusNode _areaCodeFN = FocusNode();
  FocusNode _phoneFN = FocusNode();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

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
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.left,
                  autoFocus: true,
                  onSubmitted: (s) {
                    FocusScope.of(context).requestFocus(this._phoneFN);
                  },
                  keyboardAppearance: Brightness.light,
                ),
                Row(
                  children: <Widget>[
                    Container(
                      width: 55.0,
                      child: TextView(
                        controller: this._areaCodeTEC,
                        focusNode: this._areaCodeFN,
                        hintText: '+1',
                        hintStyle: TextStyle(
                          color: Config.tColor.withOpacity(0.5),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.none,
                        color: Config.tColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                        onSubmitted: (s) {},
                        keyboardAppearance: Brightness.light,
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: TextView(
                        controller: this._phoneTEC,
                        focusNode: this._phoneFN,
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          color: Config.tColor.withOpacity(0.5),
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        textCapitalization: TextCapitalization.none,
                        color: Config.tColor,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                        onSubmitted: (s) {},
                        keyboardAppearance: Brightness.light,
                      ),
                    ),
                  ],
                ),
                Button(
                  margin: EdgeInsets.only(top: 15.0),
                  text: 'Next',
                  color: Config.pColor,
                  outline: false,
                  onTap: () {
                    Functions.navigateTo(
                        context: context,
                        w: Password(address: widget.address, photo: widget.photo, name: widget.name, email: this._emailTEC.text, phone: this._areaCodeTEC.text + ' ' + this._phoneTEC.text),
                        fullscreenDialog: false);
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
      title: 'Contact',
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
      heroTag: 'Contact',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }
}
