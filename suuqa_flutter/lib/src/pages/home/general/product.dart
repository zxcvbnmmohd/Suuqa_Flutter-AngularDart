import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suuqa_common/suuqa_common.dart' as S;
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/tabs/chats/chat.dart';
import 'package:suuqa/src/pages/home/tabs/chats/inner_chat/buy.dart';
import 'package:suuqa/src/pages/home/tabs/chats/inner_chat/messages.dart';
import 'package:suuqa/src/widgets/essentials/button.dart';
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';

class Product extends StatefulWidget {
  final S.Product product;
  final S.User pUser;

  Product({this.product, this.pUser});

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    S.User cUser = InheritedUser.of(context).user;
    NumberFormat nm = NumberFormat("\$#,##0.00", "en_US");

    Widget w = Stack(
      children: <Widget>[
        Hero(
          tag: widget.product.productID,
          child: Container(
            height: double.infinity,
            child: PageView.builder(
              controller: PageController(initialPage: 0),
              itemBuilder: (context, index) {
                return Image.network(
                  widget.product.images[index],
                  fit: BoxFit.fitHeight,
                );
              },
              itemCount: widget.product.images.length,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(15.0),
              decoration: BoxDecoration(borderRadius: S.Config.borderRadius, color: Colors.white),
              margin: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(widget.product.category, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
                  FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(widget.product.title, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold))),
                  Text(widget.pUser.name, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500)),
                  SizedBox(height: 15.0),
                  Text(widget.product.description, style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500)),
                  SizedBox(height: 10.0),
                  Text(nm.format(widget.product.total), style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                  SizedBox(height: 15.0),
                  widget.product.user.documentID == cUser.userID
                      ? Row(
                          children: <Widget>[
                            Expanded(
                              child: Button(
                                text: 'Edit Product',
                                color: S.Config.pColor,
                                outline: true,
                                onTap: () {
                                  print('tap');
                                },
                              ),
                            ),
                          ],
                        )
                      : Row(
                          children: <Widget>[
                            Expanded(
                              child: Button(
                                text: 'Chat',
                                color: S.Config.pColor,
                                outline: true,
                                onTap: () {
                                  print('tap');
                                  Functions.navigateTo(
                                      context: context,
                                      w: Messages(product: widget.product, cUser: cUser),
                                      fullscreenDialog: false);
                                },
                              ),
                            ),
                            widget.product.forDelivery ? SizedBox(width: 15.0) : Container(),
                            widget.product.forDelivery
                                ? Expanded(
                                    child: Button(
                                      text: 'Buy Now',
                                      color: S.Config.pColor,
                                      outline: false,
                                      onTap: () {
                                        Functions.navigateTo(context: context, w: Buy(), fullscreenDialog: false);
                                      },
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
        Platform.isIOS
            ? CupertinoNavigationBar(
                backgroundColor: Colors.transparent,
                border: Border.all(color: Colors.transparent, width: 0.0, style: BorderStyle.none),
                automaticallyImplyLeading: false,
                leading: Container(
                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                  child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ))
            : AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                leading: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }))
      ],
    );

    return Material(child: w);
  }
}
