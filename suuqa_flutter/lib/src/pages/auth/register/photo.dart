import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/auth/register/name.dart';
import 'package:suuqa/src/widgets/essentials/button.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Photo extends StatefulWidget {
  final Address address;

  Photo({this.address});

  @override
  _PhotoState createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  File _photo = File(Config.pathPlaceholderProfile);
  bool _didChangeImage = false;

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
                Center(
                  child: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0),
                      width: 150.0,
                      height: 150.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: this._didChangeImage ? FileImage(this._photo) : AssetImage(Config.pathUploadPhoto),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    onTap: () {
                      Functions.addPhoto(
                          context: context,
                          onSuccess: (image) {
                            if (image != null) {
                              setState(() {
                                this._photo = image;
                                this._didChangeImage = true;
                              });
                            }
                          });
                    },
                  ),
                ),
                Button(
                  text: 'Next',
                  color: Config.pColor,
                  outline: false,
                  onTap: () {
                    Functions.navigateTo(
                      context: context,
                      w: Name(address: widget.address, photo: this._photo),
                      fullscreenDialog: false,
                    );
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
      title: 'Photo',
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
      heroTag: 'Photo',
      androidView: ListView(children: w),
      iOSView: SliverList(delegate: SliverChildListDelegate(w)),
    );
  }
}
