import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/tabs/feed/camera/camera.dart';
import 'package:suuqa/src/pages/home/tabs/feed/search/search.dart';
import 'package:suuqa/src/pages/home/tabs/feed/filter.dart';
import 'package:suuqa/src/widgets/essentials/categories.dart';
import 'package:suuqa/src/widgets/essentials/empty_list.dart';
import 'package:suuqa/src/widgets/essentials/section.dart';
import 'package:suuqa/src/widgets/inherited/inherited_camera.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';
import 'package:suuqa/src/widgets/lists/list/feed_list.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Feed extends StatefulWidget {
  final User cUser;

  Feed({this.cUser});

  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  List<Address> _addresses = [];
  int _addressIndex, _limitTo, _sortBy;
  double _radius, _priceMin, _priceMax;
  List<Product> _products = [];

  @override
  void initState() {
    super.initState();

    if (widget.cUser == null) {
//      Functions.showAutoComplete(onSuccess: (p) {
//        this._addresses.add(Address(
//            type: 'Your Location',
//            short: p.name,
//            long: p.address,
//            geoPoint: Address().toGeoPoint(p.latitude, p.longitude)));
//      });
    } else {
      this._addresses = widget.cUser.addresses;
    }

    this._initVariables(addressIndex: 0, radius: 10.0, limitTo: 15, priceMin: 0.0, priceMax: 9999.0, sortBy: 1);
    this._initProducts(
        products: this._products,
        limitTo: this._limitTo,
        priceMin: this._priceMin,
        priceMax: this._priceMax,
        sortBy: this._sortBy);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> w = // this._addresses.isNotEmpty
//        ? [
//            Container(
//              child: Column(
//                children: <Widget>[],
//              ),
//            ),
//          ]
//        :
        [
      Section(text: 'Categories'),
      Categories(
          addresses: this._addresses,
          addressIndex: this._addressIndex,
          radius: this._radius,
          limitTo: this._limitTo,
          priceMin: this._priceMin,
          priceMax: this._priceMax,
          sortBy: this._sortBy),
      Section(text: 'Feed'),
      this._products.length == 0
          ? EmptyList(title: 'No Products', subtitle: 'Try Again...')
          : FeedList(products: this._products),
    ];

    return PAScaffold(
        iOSLargeTitle: true,
        iOSMiddle: false,
        color: Config.bgColor,
        title: 'Suuqa',
        leading: Platform.isIOS ? Container() : null,
        middle: Text('', style: TextStyle(color: Config.tColor)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_list),
            color: Config.tColor,
            onPressed: () {
              Functions.popup(
                  context: context,
                  w: Filter(
                    addresses: this._addresses,
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
                      this._initProducts(
                          products: this._products,
                          limitTo: this._limitTo,
                          priceMin: this._priceMin,
                          priceMax: this._priceMax,
                          sortBy: this._sortBy);
                      Navigator.pop(context);
                    },
                  ));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            color: Config.tColor,
            onPressed: () {
              Scaffold.of(context).showSnackBar(SnackBar(content: Text('Search')));
              Functions.popup(
                  context: context,
                  w: Search(
                    addresses: this._addresses,
                    addressIndex: this._addressIndex,
                    radius: this._radius,
                    priceMin: this._priceMin,
                    priceMax: this._priceMax,
                    sortBy: this._sortBy,
                  ));
            },
          ),
          InheritedUser.of(context).isLoggedIn
              ? IconButton(
                  icon: Icon(Icons.add_to_photos),
                  color: Config.tColor,
                  onPressed: () {
                    Functions.dialog(context: context, title: 'Upload a ...', actions: [
                      CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                          Functions.popup(context: context, w: Camera(cameras: InheritedCamera.of(context).cameras));
                        },
                        child: Text('Product'),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                          Functions.popup(context: context, w: Container());
                        },
                        child: Text('Service'),
                      ),
                    ], options: [
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context);
                          Functions.popup(context: context, w: Camera(cameras: InheritedCamera.of(context).cameras));
                        },
                        child: Text('Product'),
                      ),
                      SimpleDialogOption(
                        onPressed: () {
                          Navigator.pop(context);
                          Functions.popup(context: context, w: Container());
                        },
                        child: Text('Service'),
                      ),
                    ]);
                  },
                )
              : Container(),
        ],
        heroTag: 'Feed',
        androidView: ListView(children: w),
        iOSView: SliverList(delegate: SliverChildListDelegate(w)));
  }

  // MARK - Functions

  _initVariables({int addressIndex, double radius, int limitTo, double priceMin, double priceMax, int sortBy}) {
    setState(() {
      this._addressIndex = addressIndex;
      this._radius = radius;
      this._limitTo = limitTo;
      this._priceMin = priceMin;
      this._priceMax = priceMax;
      this._sortBy = sortBy;
    });
  }

  _initProducts({List<Product> products, int limitTo, double priceMin, double priceMax, int sortBy}) {
    products.clear();

    APIs().products.observeProducts(
        limitTo: limitTo,
        priceMin: priceMin,
        priceMax: priceMax,
        onEmpty: () {
          print('No Products');
        },
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

//  _initGeoProducts() {
//    APIs()
//        .products
//        .observeGeoProducts(
//            geoPoint: widget.cUser.addresses[this._addressIndex].geoPoint,
//            radius: this._radius,
//            priceMin: this._priceMin,
//            priceMax: this._priceMax,
//            limitTo: this._limitTo)
//        .listen((products) {
//      if (products.isNotEmpty) {
//        setState(() {
//          this._products.clear();
//          this._products = products;
//        });
//      } else {
//        print('No Products');
//      }
//    });
//  }
}
