import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/general/product.dart' as G;
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';

class SingleItem extends StatelessWidget {
  final Product product;

  SingleItem({this.product});

  @override
  Widget build(BuildContext context) {
    final cUser = InheritedUser.of(context).user;
    final nm = NumberFormat("\$#,##0.00", "en_US");

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
              child: Hero(
                tag: this.product.productID,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: Config.borderRadius,
                    image: DecorationImage(image: NetworkImage(this.product.images.first), fit: BoxFit.fitWidth)
                  ),
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
