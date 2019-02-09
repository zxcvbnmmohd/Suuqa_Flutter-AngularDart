import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/general/product.dart' as G;
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';

class MultipleItem extends StatelessWidget {
  final Product product;

  MultipleItem({this.product});

  @override
  Widget build(BuildContext context) {
    final cUser = InheritedUser.of(context).user;
    final nm    = NumberFormat("\$#,##0.00", "en_US");

    return GestureDetector(
      child: Container(
        height: 200.0,
        margin: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      this.product.title,
                      style: TextStyle(color: Config.tColor, fontSize: 15.0, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Text(
                    nm.format(this.product.total),
                    style: TextStyle(color: Config.tColor, fontSize: 15.0, fontWeight: FontWeight.w200),
                    textAlign: TextAlign.right,
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(image: NetworkImage(this.product.images[0]), fit: BoxFit.cover),
                          borderRadius: Config.borderRadius,
                        ),
                      ),
                    ),
                    SizedBox(width: 5.0),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(image: NetworkImage(this.product.images[1]), fit: BoxFit.cover),
                                      borderRadius: Config.borderRadius,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(image: NetworkImage(this.product.images[2]), fit: BoxFit.cover),
                                      borderRadius: Config.borderRadius,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 5.0),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(image: NetworkImage(this.product.images[3]), fit: BoxFit.cover),
                                      borderRadius: Config.borderRadius,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 5.0),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(image: NetworkImage(this.product.images[4]), fit: BoxFit.cover),
                                      borderRadius: Config.borderRadius,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
        User user = this.product.user.documentID == cUser.userID
            ? cUser
            : await APIs().users.user(userID: this.product.user.documentID);
        Functions.navigateTo(context: context, w: G.Product(product: this.product, pUser: user), fullscreenDialog: true);
      },
    );
  }
}
