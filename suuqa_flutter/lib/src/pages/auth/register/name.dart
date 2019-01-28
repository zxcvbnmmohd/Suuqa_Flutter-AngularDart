import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/auth/register/contact.dart';
import 'package:suuqa/src/widgets/essentials/button.dart';
import 'package:suuqa/src/widgets/essentials/text_view.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Name extends StatefulWidget {
  final Address address;
  final File photo;

  Name({this.address, this.photo});

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Name> {
  TextEditingController _firstNameTEC = new TextEditingController();
  TextEditingController _lastNameTEC = new TextEditingController();
  FocusNode _firstNameFN = new FocusNode();
  FocusNode _lastNameFN = new FocusNode();

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
                TextView(
                  controller: this._firstNameTEC,
                  focusNode: this._firstNameFN,
                  hintText: 'First Name',
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
                  onSubmitted: (s) {
                    FocusScope.of(context).requestFocus(this._lastNameFN);
                  },
                  keyboardAppearance: Brightness.light,
                ),
                TextView(
                  controller: this._lastNameTEC,
                  focusNode: this._lastNameFN,
                  hintText: 'Last Name',
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
                  onSubmitted: (s) {},
                  keyboardAppearance: Brightness.light,
                ),
                Button(
                  margin: EdgeInsets.only(top: 15.0),
                  text: 'Next',
                  color: Config.pColor,
                  outline: false,
                  onTap: () {
                    Functions.navigateTo(
                        context: context,
                        w: Contact(
                            address: widget.address,
                            photo: widget.photo,
                            name: this._firstNameTEC.text + ' ' + this._lastNameTEC.text),
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
      title: 'Name',
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
      heroTag: 'Name',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }
}
