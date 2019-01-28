import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/essentials/text_view.dart';

class Search extends StatefulWidget {
  final ValueChanged<String> onSubmitted;

  Search({this.onSubmitted});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController _searchTEC = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(25.0),
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Container(
              height: 55.0,
              margin: EdgeInsets.only(top: Platform.isIOS ? 240.0 : 155.0),
              child: Center(
                child: TextView(
                  controller: this._searchTEC,
                  hintText: 'Search Products',
                  hintStyle: TextStyle(color: Config.tColor.withOpacity(0.5), fontSize: 35.0, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.search,
                  textCapitalization: TextCapitalization.words,
                  color: Colors.white,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  autoFocus: true,
                  autoCorrect: true,
                  keyboardAppearance: Brightness.light,
                  onSubmitted: widget.onSubmitted,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
