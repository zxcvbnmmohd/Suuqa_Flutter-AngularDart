import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart' as S;
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/auth/register/photo.dart';
import 'package:suuqa/src/widgets/essentials/button.dart';
import 'package:suuqa/src/widgets/essentials/text_view.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Address extends StatefulWidget {
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  TextEditingController _addressTEC = new TextEditingController();
  FocusNode _addressFN = new FocusNode();
  TextEditingController _typeTEC = new TextEditingController();
  FocusNode _typeFN = new FocusNode();
  TextEditingController _insTEC = new TextEditingController();
  FocusNode _insFN = new FocusNode();
  S.Address _address;

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
                  controller: this._typeTEC,
                  focusNode: this._typeFN,
                  hintText: 'Type',
                  hintStyle: TextStyle(
                    color: S.Config.tColor.withOpacity(0.5),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  color: S.Config.tColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.left,
                  onSubmitted: (s) {
                    this._getAddress(context: context);
                  },
                  keyboardAppearance: Brightness.light,
                ),
                TextView(
                  controller: this._addressTEC,
                  focusNode: this._addressFN,
                  hintText: 'Address',
                  hintStyle: TextStyle(
                    color: S.Config.tColor.withOpacity(0.5),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  color: S.Config.tColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.left,
                  onSubmitted: (s) {},
                  keyboardAppearance: Brightness.light,
                  onTap: () {
                    this._getAddress(context: context);
                  },
                ),
                TextView(
                  controller: this._insTEC,
                  focusNode: this._insFN,
                  hintText: 'Instructions',
                  hintStyle: TextStyle(
                    color: S.Config.tColor.withOpacity(0.5),
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.sentences,
                  color: S.Config.tColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.left,
                  onChanged: (s) {
                    this._address.instructions = s;
                  },
                  onSubmitted: (s) {
                    this._address.instructions = s;
                    Functions.navigateTo(context: context, w: Photo(address: this._address), fullscreenDialog: false);
                  },
                  keyboardAppearance: Brightness.light,
                ),
                Button(
                  margin: EdgeInsets.only(top: 15.0),
                  text: 'Next',
                  color: S.Config.pColor,
                  outline: false,
                  onTap: () {
                    Functions.navigateTo(context: context, w: Photo(address: this._address), fullscreenDialog: false);
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
      color: S.Config.bgColor,
      title: 'Address',
      leading: IconButton(
        icon: Icon(
          Icons.close,
          color: S.Config.pColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[Container()],
      heroTag: 'Address',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }

  // MARK - Functions

  _getAddress({BuildContext context}) {
    Functions.showAutoComplete(onSuccess: (p) {
      setState(() {
        this._addressTEC.text = p.name;
        this._address = new S.Address(
            type: this._typeTEC.text,
            short: p.name,
            long: p.address,
            geoPoint: S.Address().toGeoPoint(p.latitude, p.longitude));
        FocusScope.of(context).requestFocus(this._insFN);
      });
    });
  }
}
