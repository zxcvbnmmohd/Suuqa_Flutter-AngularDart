import 'dart:io';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/tabs/feed/search/search_feed.dart';
import 'package:suuqa/src/widgets/essentials/text_view.dart';

class Search extends StatelessWidget {
  final List<Address> addresses;
  final int addressIndex;
  final double radius;
  final int limitTo;
  final double priceMin;
  final double priceMax;
  final int sortBy;

  Search({this.addresses, this.addressIndex, this.radius, this.limitTo, this.priceMin, this.priceMax, this.sortBy});

  final TextEditingController _searchTEC = new TextEditingController();

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
                  onSubmitted: (s) {
                    Navigator.pop(context);
                    if (s.isNotEmpty) {
                      Functions.navigateTo(
                          context: context,
                          w: SearchFeed(
                              search: s,
                              addresses: this.addresses,
                              addressIndex: this.addressIndex,
                              radius: this.radius,
                              priceMin: this.priceMin,
                              priceMax: this.priceMax,
                              sortBy: this.sortBy),
                          fullscreenDialog: false);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}