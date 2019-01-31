import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suuqa_common/suuqa_common.dart';
import 'package:suuqa/src/functions.dart';
import 'package:suuqa/src/pages/home/general/product.dart' as G;
import 'package:suuqa/src/widgets/inherited/inherited_user.dart';

class SliderItem extends StatelessWidget {
  final Product product;

  SliderItem({this.product});

  @override
  Widget build(BuildContext context) {
    final cUser = InheritedUser.of(context).user;
    final nm    = NumberFormat("\$#,##0.00", "en_US");

    return GestureDetector(
      child: Container(
        height: 200.0,
        margin: EdgeInsets.only(bottom: 10.0),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 25.0, right: 25.0, bottom: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      this.product.title,
                      style: TextStyle(color: Config.tColor, fontSize: 15.0, fontWeight: FontWeight.bold),
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
                  child: PageView.builder(
                    controller: PageController(initialPage: 0, viewportFraction: 0.9),
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          image: DecorationImage(image: NetworkImage(this.product.images[index]), fit: BoxFit.cover),
                          borderRadius: Config.borderRadius,
                        ),
//                      width: 300.0,
                        margin: EdgeInsets.only(left: 5.0, right: 5.0),
                      );
                    },
                    itemCount: this.product.images.length,
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
