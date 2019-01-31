import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/tabs/feed/category_feed.dart';

class Categories extends StatelessWidget {
  final List<Address> addresses;
  final int addressIndex;
  final double radius;
  final int limitTo;
  final double priceMin;
  final double priceMax;
  final int sortBy;

  Categories({this.addresses, this.addressIndex, this.radius, this.limitTo, this.priceMin, this.priceMax, this.sortBy});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: Container(
                padding: EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  color: Config.sColor,
                  borderRadius: Config.borderRadius,
                ),
                width: 150.0,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Config.categories[index],
                      style: TextStyle(
                        color: Config.bgColor,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Functions.navigateTo(
                  context: context,
                  w: CategoryFeed(
                      category: Config.categories[index],
                      addresses: this.addresses,
                      addressIndex: this.addressIndex,
                      radius: this.radius,
                      limitTo: this.limitTo,
                      priceMin: this.priceMin,
                      priceMax: this.priceMax,
                      sortBy: this.sortBy),
                  fullscreenDialog: false,
                );
              },
            );
          },
          itemCount: Config.categories.length),
    );
  }
}
