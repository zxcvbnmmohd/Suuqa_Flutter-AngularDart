import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/tabs/feed/search/search.dart';
import 'package:suuqa/src/pages/home/tabs/feed/search/search_feed.dart';
import 'package:suuqa/src/pages/home/tabs/feed/filter.dart';
import 'package:suuqa/src/widgets/essentials/empty_list.dart';
import 'package:suuqa/src/widgets/lists/list/feed_list.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class CategoryFeed extends StatefulWidget {
  final String category;
  final int addressIndex;
  final double radius;
  final int limitTo;
  final double priceMin;
  final double priceMax;
  final int sortBy;

  CategoryFeed({this.category, this.addressIndex, this.radius, this.limitTo, this.priceMin, this.priceMax, this.sortBy});

  @override
  _CategoryFeedState createState() => _CategoryFeedState();
}

class _CategoryFeedState extends State<CategoryFeed> {
  String _category;
  int _addressIndex;
  double _radius;
  int _limitTo;
  double _priceMin;
  double _priceMax;
  int _sortBy;
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();
    this._initVariables(
        category: widget.category,
        addressIndex: widget.addressIndex,
        radius: widget.radius,
        limitTo: widget.limitTo,
        priceMin: widget.priceMin,
        priceMax: widget.priceMax,
        sortBy: widget.sortBy);
    this._initProductsIn(
        category: this._category,
        products: this._products,
        limitTo: this._limitTo,
        priceMin: this._priceMin,
        priceMax: this._priceMax);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> w = [
      this._products.length == 0
          ? EmptyList(title: 'No Products', subtitle: 'Try Again...')
          : FeedList(products: this._products),
    ];

    return PAScaffold(
        iOSLargeTitle: true,
        color: Config.bgColor,
        title: widget.category,
        leading: IconButton(
            icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
            color: Config.tColor,
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            color: Config.tColor,
            onPressed: () {
              Functions.popup(
                  context: context,
                  w: Filter(
                    addressIndex: this._addressIndex,
                    radius: this._radius,
                    priceMin: this._priceMin,
                    priceMax: this._priceMax,
                    sortBy: this._sortBy,
                    onTap: (aIndex, radius, pMin, pMax, sortBy) {
                      setState(() {
                        this._addressIndex = aIndex;
                        this._radius = radius;
                        this._priceMin = pMin;
                        this._priceMax = pMax;
                        this._sortBy = sortBy;
                      });
//                      this._initProducts();
                      Navigator.pop(context);
                    },
                  ));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            color: Config.tColor,
            onPressed: () {
              Functions.popup(
                  context: context,
                  w: Search(onSubmitted: (s) {
                    s.length == 0
                        ? Navigator.pop(context)
                        : Functions.navigateTo(context: context, w: SearchFeed(search: s), fullscreenDialog: false);
                    Navigator.pop(context);
                  }));
            },
          ),
        ],
        heroTag: 'CategoryFeed',
        androidView: ListView(children: w),
        iOSView: SliverList(delegate: SliverChildListDelegate(w)));
  }

  // MARK - Functions

  _initVariables(
      {String category, int addressIndex, double radius, int limitTo, double priceMin, double priceMax, int sortBy}) {
    setState(() {
      this._category = category;
      this._addressIndex = addressIndex;
      this._radius = radius;
      this._limitTo = limitTo;
      this._priceMin = priceMin;
      this._priceMax = priceMax;
      this._sortBy = sortBy;
    });
  }

  _initProductsIn({String category, List<Product> products, int limitTo, double priceMin, double priceMax, int sortBy}) {
    APIs().products.observeCategoryProducts(
        category: category,
        limitTo: limitTo,
        priceMin: priceMin,
        priceMax: priceMax,
        onAdded: (p) {
          setState(() {
            products.add(p);
            this._sortProducts(products: products, sortBy: sortBy);
          });
        },
        onModified: (p) {
          int i = products.indexWhere((product) => product.productID == p.productID);
          setState(() {
            products[i] = p;
            this._sortProducts(products: products, sortBy: sortBy);
          });
        },
        onRemoved: (p) {
          int i = products.indexWhere((product) => product.productID == p.productID);
          setState(() {
            products.removeAt(i);
            this._sortProducts(products: products, sortBy: sortBy);
          });
        },
        onEmpty: () {
          print('No Products');
        },
        onFailure: (e) {
          print(e);
        });
  }

  _sortProducts({List<Product> products, int sortBy}) {
    switch (sortBy) {
      case 0:
        products.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
        break;
      case 1:
        products.sort((b, a) => a.updatedAt.compareTo(b.updatedAt));
        break;
      case 2:
        products.sort((a, b) => a.total.compareTo(b.total));
        break;
      case 3:
        products.sort((b, a) => a.total.compareTo(b.total));
        break;
    }
  }
}
