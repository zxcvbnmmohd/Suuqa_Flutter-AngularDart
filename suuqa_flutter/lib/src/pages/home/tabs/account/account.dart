import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suuqa/src/widgets/essentials/empty_list.dart';
import 'package:suuqa/src/widgets/essentials/section.dart';
import 'package:suuqa/src/widgets/lists/list/feed_list.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/home.dart';
import 'package:suuqa/src/pages/auth/login.dart';
import 'package:suuqa/src/pages/auth/register/address.dart' as A;
import 'package:suuqa/src/pages/home/tabs/account/settings/settings.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';
import 'package:suuqa/src/widgets/platform_aware/pa_scaffold.dart';

class Account extends StatefulWidget {
  final User cUser;

  Account({this.cUser});

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  List<Product> _products = [];
  List<Product> _services = [];

  @override
  void initState() {
    super.initState();
    this._initProducts(userID: widget.cUser.userID, limitTo: 10, products: this._products);
  }

  @override
  Widget build(BuildContext context) {
    final cUser = InheritedUser.of(context);
    final nm = NumberFormat("###000");
    List<Widget> w = cUser.isLoggedIn
        ? [
            SizedBox(height: 25.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 125.0,
                    width: 125.0,
                    margin: EdgeInsets.only(bottom: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      image: DecorationImage(image: NetworkImage(cUser.user.aviURL), fit: BoxFit.cover),
                    ),
                  ),
                  Text(cUser.user.name, style: TextStyle(color: Config.tColor, fontSize: 25.0, fontWeight: FontWeight.bold)),
                  Text(cUser.user.email,
                      style: TextStyle(color: Config.tColor, fontSize: 20.0, fontWeight: FontWeight.w300)),
                  SizedBox(height: 15.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(nm.format(cUser.user.count.products),
                              style: TextStyle(color: Config.tColor, fontSize: 25.0, fontWeight: FontWeight.w300)),
                          Text('Products',
                              style: TextStyle(color: Config.tColor, fontSize: 13.0, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(nm.format(cUser.user.count.sold),
                              style: TextStyle(color: Config.tColor, fontSize: 25.0, fontWeight: FontWeight.w300)),
                          Text('Sold', style: TextStyle(color: Config.tColor, fontSize: 13.0, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(nm.format(cUser.user.count.services),
                              style: TextStyle(color: Config.tColor, fontSize: 25.0, fontWeight: FontWeight.w300)),
                          Text('Services',
                              style: TextStyle(color: Config.tColor, fontSize: 13.0, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(cUser.user.count.rating.toStringAsFixed(1),
                              style: TextStyle(color: Config.tColor, fontSize: 25.0, fontWeight: FontWeight.w300)),
                          Text('Rating',
                              style: TextStyle(color: Config.tColor, fontSize: 13.0, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Section(text: 'Products'),
            this._products.length == 0
                ? EmptyList(title: 'No Products...', subtitle: 'Upload a Product!')
                : FeedList(products: this._products),
            Section(text: 'Services'),
            this._services.length == 0
                ? EmptyList(title: 'No Services...', subtitle: 'Add a Service!')
                : Container(),
            SizedBox(height: 25.0),
          ]
        : [
            SizedBox(height: 25.0),
            this._tile(
                title: 'Login',
                subTitle: '',
                icon: Icon(Icons.navigate_next, color: Config.bgColor),
                onTap: () {
                  Functions.navigateTo(context: context, w: Login(), fullscreenDialog: true);
                }),
            this._tile(
                title: 'Register',
                subTitle: '',
                icon: Icon(Icons.navigate_next, color: Config.bgColor),
                onTap: () {
                  Functions.navigateTo(context: context, w: A.Address(), fullscreenDialog: true);
                }),
          ];

    return PAScaffold(
        iOSLargeTitle: true,
        color: Config.bgColor,
        title: 'Account',
        leading: Platform.isIOS ? Container() : null,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            onPressed: () {
              Functions.dialog(context: context, title: 'S', actions: [
                CupertinoActionSheetAction(
                    onPressed: () {
                      Functions.navigateTo(context: context, w: Settings());
                    },
                    child: Text('Settings')),
                CupertinoActionSheetAction(
                    onPressed: () {
                      Services().auth.logout(onSuccess: () {
                        cUser.isLoggedIn = false;
                        cUser.user = null;
                        Functions.navigateAndReplaceWith(context: context, w: Home());
                      }, onFailure: (e) {
                        print(e);
                      });
                    },
                    isDestructiveAction: true,
                    child: Text('Logout')),
              ], options: []);
            },
          )
        ],
        heroTag: 'Account',
        androidView: ListView(children: w),
        iOSView: SliverList(delegate: SliverChildListDelegate(w)));
  }

  // MARK - Functions

  Widget _tile({String title, String subTitle, Widget icon, Function onTap}) {
    return Container(
      decoration: BoxDecoration(
        color: Config.wColor,
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      margin: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 15.0),
      child: ListTile(
        title: Text(title, style: TextStyle(color: Config.bgColor)),
        subtitle: subTitle.length == 0 ? null : Text(subTitle, style: TextStyle(color: Config.bgColor)),
        trailing: icon,
        onTap: onTap,
      ),
    );
  }

  _initProducts({String userID, int limitTo, List<Product> products}) {
    APIs().products.observeUserSellingProducts(
        userID: userID,
        limitTo: limitTo,
        onAdded: (p) {
          setState(() {
            products.add(p);
            products.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
          });
        },
        onModified: (p) {
          int i = products.indexWhere((product) => product.productID == p.productID);
          setState(() {
            products[i] = p;
            products.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
          });
        },
        onRemoved: (p) {
          int i = products.indexWhere((product) => product.productID == p.productID);
          setState(() {
            products.removeAt(i);
            products.sort((a, b) => a.updatedAt.compareTo(b.updatedAt));
          });
        },
        onFailure: (e) {
          print(e);
        });
  }
}
