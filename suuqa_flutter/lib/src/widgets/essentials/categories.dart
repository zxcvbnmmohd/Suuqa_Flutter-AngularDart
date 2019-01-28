import 'dart:math';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/tabs/feed/category_feed.dart';

class Categories extends StatelessWidget {
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
                  color: Config.wColor,
                  borderRadius: Config.borderRadius,
                ),
                width: 150.0,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      Config.categories[index] == 'Services'
                          ? '${Random().nextInt(1000)} Services'
                          : '${Random().nextInt(1000)} Products',
                      style: TextStyle(
                        color: Config.bgColor,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
                  w: CategoryFeed(category: Config.categories[index]),
                  fullscreenDialog: false,
                );
              },
            );
          },
          itemCount: Config.categories.length),
    );
  }
}
