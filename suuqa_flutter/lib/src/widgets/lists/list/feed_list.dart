import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/widgets/lists/item/feed/multiple_item.dart';
import 'package:suuqa/src/widgets/lists/item/feed/single_item.dart';
import 'package:suuqa/src/widgets/lists/item/feed/slider_item.dart';

class FeedList extends StatelessWidget {
  final List<Product> products;

  FeedList({this.products});

  @override
  Widget build(BuildContext context) {
    return this.products == null
        ? Center(child: Platform.isIOS ? CupertinoActivityIndicator() : CircularProgressIndicator())
        : ListView.builder(
            physics: ClampingScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 0.0),
            itemBuilder: (context, index) {
              Product p = this.products[index];

              switch (p.images.length) {
                case 1:
                  return SingleItem(product: p);
                  break;
                case 5:
                  return MultipleItem(product: p);
                  break;
                default:
                  return SliderItem(product: p);
                  break;
              }
            },
            itemCount: this.products.length,
          );
  }
}
